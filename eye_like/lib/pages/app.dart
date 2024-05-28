import 'dart:io';

import 'package:eye_like/components/mode_button_widget.dart';
import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/pages/allergy_first.dart';
import 'package:eye_like/pages/basic_first.dart';
import 'package:eye_like/pages/disease_first.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.put(ImageController());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '여러분을 위한',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              '식품 쇼핑 가이드 앱',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: const Alignment(-0.1, 0), //이미지 가운데 정렬 안되서 추가
              child: SizedBox(
                width: 220,
                height: 200,
                child: Image.asset('assets/images/main_logo.png'),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ModeButtonWidget(
              mode: '기본모드',
              type: ModeButtonType.type2,
              onPressed: () {
                Get.to(BasicFirst());
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ModeButtonWidget(
              mode: '질병모드',
              type: ModeButtonType.type2,
              onPressed: () {
                Get.to(DiseaseFirst());
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ModeButtonWidget(
              mode: '알레르기모드',
              type: ModeButtonType.type2,
              onPressed: () {
                Get.to(AllergyFirst());
              },
            ),
            // const SizedBox(
            //   height: 16,
            // ),
            // Obx(
            //   () => controller.imageFile.value != null //카메라 이미지 업데이트 되는지 확인 필요
            //       ? Image.file(
            //           File(controller.imageFile.value!.path),
            //           width: 100,
            //           height: 100,
            //         )
            //       : Container(
            //           width: 100,
            //           height: 100,
            //           color: Colors.grey,
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
