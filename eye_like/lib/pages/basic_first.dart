import 'dart:io';

import 'package:eye_like/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicFirst extends StatelessWidget {
  BasicFirst({super.key});
  final ImageController controller = Get.put(ImageController());

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
