import 'dart:io';

import 'package:eye_like/controllers/allergy_fifth_controller.dart';
import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/controllers/select_controller_2.dart';
import 'package:eye_like/controllers/setting_controller.dart';
import 'package:eye_like/controllers/text_recognition_controller.dart';
import 'package:eye_like/pages/allergy_sixth.dart';
import 'package:eye_like/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AllergyFifth extends StatefulWidget {
  final List<String> selectedAllergies;

  const AllergyFifth({Key? key, required this.selectedAllergies})
      : super(key: key);

  @override
  State<AllergyFifth> createState() => _AllergyFifthState();
}

class _AllergyFifthState extends State<AllergyFifth> {
  final SettingsController settingsController = Get.put(SettingsController());
  final SelectController2 selectController = Get.put(SelectController2());
  ImageController controller = Get.put(ImageController());
  AllergyFifthController commentController = Get.put(AllergyFifthController());
  final TextRecognitionService _textRecognitionService =
      TextRecognitionService();
  FlutterTts flutterTts = FlutterTts();
  String extractedText = '';
  String extractedText2 = '';

  @override
  void initState() {
    super.initState();
    commentController.setSelectedAllergies(widget.selectedAllergies);
    extractText();
  }

  Future<void> extractText() async {
    ByteData data = await rootBundle.load('assets/images/food_label.jpeg');
    Uint8List bytes = data.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    File imageFile =
        await File('${tempDir.path}/food_label.jpeg').writeAsBytes(bytes);

    try {
      String text =
          await _textRecognitionService.recognizeTextFromImage(imageFile);

      // 첫 번째 정규표현식으로 알레르기 성분 추출
      RegExp regExp1 = RegExp(
          r'(난류|우유|메밀|땅콩|대두|밀|고등어|게|새우|돼지고기|복숭아|토마토|아황산류|호두|닭고기|쇠고기|오징어|조개류|잣)');
      Iterable<RegExpMatch> matches1 = regExp1.allMatches(text);

      List<String> allergyInfoList = [];

      String regexExtractedText1 = matches1.map((match) {
        String nutrient = match.group(1) ?? '';

        allergyInfoList.add(nutrient);

        return nutrient;
      }).join('\n');

      for (var nutrient in allergyInfoList) {
        commentController.updateComment(
          nutrient,
        );
      }

      RegExp regExp2 = RegExp(
          r'(트랜스지방|포화지방|지방|당류|나트륨|탄수화물|단백질|콜레스테롤|식이섬유|섬유질)\s*([\d,.]+)\s*(mg|g|ml)?');
      Iterable<RegExpMatch> matches2 = regExp2.allMatches(text);

      List<Map<String, String>> nutrientInfoList = [];

      String regexExtractedText2 = matches2.map((match) {
        String nutrient = match.group(1) ?? '';
        String value = match.group(2) ?? '';
        String unit = match.group(3) ?? '';

        value =
            value.replaceAll(RegExp(r'\D$'), ''); // 숫자 뒤에 오는 텍스트가 g이 아닌 경우 제거

        if (value.startsWith('0') && !value.startsWith('0.')) {
          value = value.substring(0, 1) + '.' + value.substring(1);
        }

        if (unit.isEmpty) {
          unit = 'g'; // 9 대신 g으로 변경
        }

        double numericValue =
            double.tryParse(value) ?? 0; // 소수 존재하기 때문에 double 변수 사용

        if (unit == 'mg') {
          numericValue /= 100;
          value = numericValue.toString();
          unit = 'g';
        }

        nutrientInfoList.add({
          'nutrient': nutrient,
          'value': value,
          'unit': unit,
        });

        return '$nutrient $value $unit';
      }).join('\n');

      setState(() {
        extractedText = regexExtractedText1;
        extractedText2 = regexExtractedText2;

        for (String allergy in widget.selectedAllergies) {
          if (extractedText.contains(allergy)) {
            commentController.updateComment(allergy);
          }
        }

        commentController.finalizeComment();

        _speak(commentController.comment.value);
        _showMessageDialog(commentController.comment.value,
            commentController.mostExtremeMessageType.value);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('ko-KR');
    await flutterTts.setSpeechRate(0.4);

    text = text.replaceAll(' g', '그램');

    // 줄바꿈 문자를 인식하여 잠시 멈추기
    List<String> lines = text.split('\n');
    for (String line in lines) {
      await flutterTts.speak(line);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _stopTts() async {
    await flutterTts.stop();
  }

  void _showMessageDialog(String message, String type) {
    Color dialogColor;

    if (type == 'positive') {
      dialogColor = const Color(0xff001AFF);
    } else if (type == 'negative') {
      dialogColor = const Color(0xffFF0000);
    } else {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => Dialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: dialogColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: settingsController.highContrastMode.value
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: dialogColor,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    child: Stack(
                      children: [
                        const Center(
                          child: Text(
                            '알림',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              _stopTts();
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: settingsController.highContrastMode.value
                            ? Colors.white
                            : Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          color: settingsController.highContrastMode.value
              ? Colors.black
              : Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 450,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: settingsController.highContrastMode.value
                            ? Colors.white
                            : Colors.black,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '영양성분',
                              style: TextStyle(
                                fontSize: settingsController.fontSize.value,
                                fontWeight: FontWeight.w600,
                                color: settingsController.highContrastMode.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              extractedText2,
                              style: TextStyle(
                                fontSize: settingsController.fontSize.value,
                                fontWeight: FontWeight.w400,
                                color: settingsController.highContrastMode.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Obx(
                      //   () => controller.imageFile.value != null //카메라 이미지 업데이트 되는지 확인 필요
                      //       ? Image.file(
                      //           File(controller.imageFile.value!.path),
                      //           width: 250,
                      //           height: 250,
                      //         )
                      //       : Container(
                      //           width: 250,
                      //           height: 250,
                      //           color: Colors.grey,
                      //         ),
                      // ),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        _stopTts();
                        commentController.resetComment();
                        Get.to(const AllergySixth());
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          color: settingsController.highContrastMode.value
                              ? const Color(0xff00FF00)
                              : const Color(0xff30D979),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          '모든정보듣기',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        _stopTts();
                        Get.to(App());
                        selectController.resetSelections();
                        commentController.resetComment();
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          color: settingsController.highContrastMode.value
                              ? const Color(0xff00FF00)
                              : const Color(0xff30D979),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          '종료',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
