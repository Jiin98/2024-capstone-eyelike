import 'dart:io';

import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/controllers/text_recognition_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BasicFirst extends StatefulWidget {
  const BasicFirst({super.key});

  @override
  State<BasicFirst> createState() => _BasicFirstState();
}

class _BasicFirstState extends State<BasicFirst> {
  ImageController controller = Get.put(ImageController());
  String extractedText = '';
  final TextRecognitionService _textRecognitionService =
      TextRecognitionService();
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    extractText();
  }

  Future<void> extractText() async {
    //텍스트 추출
    ByteData data = await rootBundle.load('assets/images/food_label_7.jpeg');
    Uint8List bytes = data.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    File imageFile =
        await File('${tempDir.path}/food_label_7.jpeg').writeAsBytes(bytes);

    try {
      String text =
          await _textRecognitionService.recognizeTextFromImage(imageFile);

      // 정규표현식 패턴
      RegExp regExp = RegExp(r'(나트륨|탄수화물|지방)\s*(\d+)\s*(mg|g)');
      // 매칭 결과
      Iterable<RegExpMatch> matches = regExp.allMatches(text);

      // 추출된 텍스트를 하나의 문자열로 저장
      String regexExtractedText =
          matches.map((match) => match.group(0)).join('\n');

      setState(() {
        extractedText = regexExtractedText;
        _speak(extractedText);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('ko-KR');
    await flutterTts.setSpeechRate(0.5); // 속도 조절 (0.0 ~ 1.0)
    await flutterTts.speak(text);
  }

  Widget _previousButton() {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        Get.back();
      },
      child: Container(
        width: 110,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xff30D979),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            '뒤로 가기',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _nextButton() {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {}, //onpressed에 대한 값을 받도록 설정
      child: Container(
        width: 110,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xff30D979),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            '완료',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            child: Image.asset('assets/images/main_logo.png'),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 250,
            height: 250,
            child: Text(extractedText),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _previousButton(),
              const SizedBox(
                width: 30,
              ),
              _nextButton(),
            ],
          ),
        ],
      ),
    );
  }
}
