import 'dart:io';

import 'package:eye_like/controllers/allergy_fifth_controller.dart';
import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/controllers/select_controller_2.dart';
import 'package:eye_like/controllers/text_recognition_controller.dart';
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
  final SelectController2 selectController = Get.put(SelectController2());
  ImageController controller = Get.put(ImageController());
  AllergyFifthController commentController = Get.put(AllergyFifthController());
  final TextRecognitionService _textRecognitionService =
      TextRecognitionService();
  FlutterTts flutterTts = FlutterTts();
  String extractedText = '';

  @override
  void initState() {
    super.initState();
    extractText();
  }

  Future<void> extractText() async {
    ByteData data = await rootBundle.load('assets/images/food_label_7.jpeg');
    Uint8List bytes = data.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    File imageFile =
        await File('${tempDir.path}/food_label_7.jpeg').writeAsBytes(bytes);

    try {
      String text =
          await _textRecognitionService.recognizeTextFromImage(imageFile);

      RegExp regExp = RegExp(
          r'(난류|우유|메밀|땅콩|대두|밀|고등어|게|새우|돼지고기|복숭아|토마토|아황산류|호두|닭고기|쇠고기|오징어|조개류|잣)');
      Iterable<RegExpMatch> matches = regExp.allMatches(text);

      List<String> allergyInfoList = [];

      String regexExtractedText = matches.map((match) {
        String nutrient = match.group(1) ?? '';

        allergyInfoList.add(nutrient);

        return nutrient;
      }).join('\n');

      for (var nutrient in allergyInfoList) {
        commentController.updateComment(
          nutrient,
        );
      }

      commentController.finalizeComment();

      setState(() {
        extractedText = regexExtractedText;

        for (String allergy in widget.selectedAllergies) {
          if (extractedText.contains(allergy)) {
            commentController.updateComment(allergy);
          }
        }

        _speak(commentController.comment.value);
        _showMessageDialog(commentController.mostExtremeMessage.value,
            commentController.mostExtremeMessageType.value);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('ko-KR');
    await flutterTts.setSpeechRate(0.3);

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
      dialogColor = Colors.green;
    } else if (type == 'negative') {
      dialogColor = const Color(0xffFF0000);
    } else {
      dialogColor = const Color(0xff001AFF);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: dialogColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 300,
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
                            Navigator.of(context).pop();
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
                    commentController.comment.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 450,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '영양성분',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          extractedText,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
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
                  },
                  child: Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff30D979),
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
                      color: const Color(0xff30D979),
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
    );
  }
}
