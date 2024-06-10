import 'dart:io';

import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/controllers/text_comment_controller.dart';
import 'package:eye_like/controllers/text_recognition_controller.dart';
import 'package:eye_like/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BasicSecond extends StatefulWidget {
  const BasicSecond({super.key});

  @override
  State<BasicSecond> createState() => _BasicSecondState();
}

class _BasicSecondState extends State<BasicSecond> {
  ImageController controller = Get.put(ImageController());
  TextCommentController commentController = Get.put(TextCommentController());
  String extractedText = '';
  String highText = '';
  final TextRecognitionService _textRecognitionService =
      TextRecognitionService();
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    extractText();
  }

  //   Future<void> extractText() async {  //전체 텍스트 추출 확인 코드
  //   //텍스트 추출
  //   ByteData data = await rootBundle.load('assets/images/food_label_7.jpeg');
  //   Uint8List bytes = data.buffer.asUint8List();
  //   Directory tempDir = await getTemporaryDirectory();
  //   File imageFile =
  //       await File('${tempDir.path}/food_label_7.jpeg').writeAsBytes(bytes);

  //   try {
  //     String text =
  //         await _textRecognitionService.recognizeTextFromImage(imageFile);
  //     setState(() {
  //       extractedText = text;
  //       _speak(extractedText);
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

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
      RegExp regExp = RegExp(
          r'(트랜스지방|포화지방|지방|당류|나트륨|탄수화물|단백질|콜레스테롤)\s*([\d,.]+)\s*(mg|g)?');
      // 매칭 결과
      Iterable<RegExpMatch> matches = regExp.allMatches(text);

      List<Map<String, String>> nutrientInfoList = [];

      // 후처리 및 모든 성분 정보 저장
      String regexExtractedText = matches.map((match) {
        String nutrient = match.group(1) ?? '';
        String value = match.group(2) ?? '';
        String unit = match.group(3) ?? '';

        // 숫자 뒤의 불필요한 문자를 제거
        value =
            value.replaceAll(RegExp(r'\D$'), ''); // 숫자 뒤에 오는 텍스트가 g이 아닌 9이면 제거

        double numericValue =
            double.tryParse(value) ?? 0; // 소수 존재하기 때문에 double 변수 사용

        // 단위를 통일하여 mg인 경우 g으로 환산
        if (unit == 'mg') {
          numericValue /= 1000;
          value = numericValue.toString();
          unit = 'g';
        }

        // 각 성분의 정보를 리스트에 저장
        nutrientInfoList.add({
          'nutrient': nutrient,
          'value': value,
          'unit': unit,
        });

        if (unit.isEmpty) {
          unit = 'g'; // 9 대신 g으로 변경
        }

        return '$nutrient $value $unit';
      }).join('\n');

      // 모든 성분 정보를 commentController에 넘겨줌
      String combinedText = '';
      nutrientInfoList.forEach((nutrientInfo) {
        commentController.updateComment(
          nutrientInfo['nutrient'] ?? '',
          nutrientInfo['value'] ?? '',
          nutrientInfo['unit'] ?? '',
        );
        combinedText +=
            '${nutrientInfo['nutrient']} ${nutrientInfo['value']} ${nutrientInfo['unit']}\n';
      });

      setState(() {
        extractedText = regexExtractedText;
        _speak(combinedText.trim());
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('ko-KR');
    await flutterTts.setSpeechRate(0.3); // 속도 조절 (0.0 ~ 1.0)

    // 줄바꿈 문자를 인식하여 잠시 멈추기
    List<String> lines = text.split('\n');
    for (String line in lines) {
      await flutterTts.speak(line);
      await Future.delayed(const Duration(seconds: 1)); // 줄마다 1초 멈춤
    }
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
            TextButton(
              onPressed: () {
                Get.to(App());
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
      ),
    );
  }
}