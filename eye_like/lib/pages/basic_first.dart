import 'dart:io';

import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/controllers/text_recognition_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BasicFirst extends StatelessWidget {
  BasicFirst({super.key});
  final ImageController controller = Get.put(ImageController());

  final TextRecognitionService _textRecognitionService =
      TextRecognitionService();
  Future<void> extractText(BuildContext context) async {
    final ByteData data = await rootBundle.load('assets/images/food_label.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final Directory tempDir = await getTemporaryDirectory();
    final File imageFile =
        await File('${tempDir.path}/food_label.png').writeAsBytes(bytes);

    try {
      String extractedText =
          await _textRecognitionService.recognizeTextFromImage(imageFile);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(extractedText),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print('오류 발생: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('오류가 발생했습니다: $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
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

  Widget _nextButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () => extractText(context), //onpressed에 대한 값을 받도록 설정
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
              _nextButton(context),
            ],
          ),
        ],
      ),
    );
  }
}
