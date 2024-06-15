import 'dart:io';

import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/controllers/setting_controller.dart';
import 'package:eye_like/controllers/text_comment_controller.dart';
import 'package:eye_like/controllers/text_recognition_controller.dart';
import 'package:eye_like/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BasicSecond extends StatefulWidget {
  final File? cameraFile;

  const BasicSecond({super.key, this.cameraFile});

  @override
  State<BasicSecond> createState() => _BasicSecondState();
}

class _BasicSecondState extends State<BasicSecond> {
  ImageController controller = Get.put(ImageController());
  final SettingsController settingsController = Get.put(SettingsController());
  TextCommentController commentController = Get.put(TextCommentController());
  final TextRecognitionService _textRecognitionService =
      TextRecognitionService();
  FlutterTts flutterTts = FlutterTts();
  var extractedText = ''.obs;
  final _isSpeaking = false.obs;

  @override
  void initState() {
    super.initState();
    extractText();
  }

  Future<void> extractText() async {
    // ByteData data = await rootBundle.load('assets/images/food_label.jpeg');
    // Uint8List bytes = data.buffer.asUint8List();
    // Directory tempDir = await getTemporaryDirectory();
    // File imageFile =
    //     await File('${tempDir.path}/food_label.jpeg').writeAsBytes(bytes);

    try {
      String text = await _textRecognitionService
          .recognizeTextFromImage(widget.cameraFile!);
          
      // String text =
      //     await _textRecognitionService.recognizeTextFromImage(imageFile);

      RegExp regExp = RegExp(
          r'(트랜스지방|포화지방|지방|당류|나트륨|탄수화물|단백질|콜레스테롤)\s*([\d,.]+)\s*(mg|g)?');
      Iterable<RegExpMatch> matches = regExp.allMatches(text);

      List<Map<String, String>> nutrientInfoList = [];

      String regexExtractedText = matches.map((match) {
        String nutrient = match.group(1) ?? '';
        String value = match.group(2) ?? '';
        String unit = match.group(3) ?? '';

        value =
            value.replaceAll(RegExp(r'\D$'), ''); // 숫자 뒤에 오는 텍스트가 g이 아닌 9이면 제거

        if (unit.isEmpty) {
          unit = 'g';
        }

        double numericValue =
            double.tryParse(value) ?? 0; // 소수 존재하기 때문에 double 변수 사용

        if (unit == 'mg') {
          numericValue /= 1000;
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
        extractedText.value = regexExtractedText;
        _speak(extractedText.value);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('ko-KR');
    await flutterTts.setSpeechRate(0.3);

     text = text.replaceAll(' g', ' gram');

    setState(() {
      _isSpeaking.value = true;
    });

    List<String> lines = text.split('\n');
    for (String line in lines) {
      if (!_isSpeaking.value) break;
      await flutterTts.speak(line);
      await Future.delayed(const Duration(seconds: 1));
    }

    setState(() {
      _isSpeaking.value = false;
    });
  }

  Future<void> _stopTts() async {
    setState(() {
      _isSpeaking.value = false;
    });
    await flutterTts.stop();
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
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '영양성분',
                              style: TextStyle(
                                fontSize: 24,
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
                              extractedText.value,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: settingsController.highContrastMode.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () async {
                    await _stopTts();
                    Get.to(App());
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
          ),
        ),
      ),
    );
  }
}
