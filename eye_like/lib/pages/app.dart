import 'dart:io';

import 'package:eye_like/components/mode_button_widget.dart';
import 'package:eye_like/controllers/image_controller.dart';
import 'package:eye_like/controllers/setting_controller.dart';
import 'package:eye_like/pages/allergy_first.dart';
import 'package:eye_like/pages/basic_first.dart';
import 'package:eye_like/pages/disease_first.dart';
import 'package:eye_like/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  App({super.key});
  final ImageController controller = Get.put(ImageController());
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Obx(() => AppBar(
              toolbarHeight: 100,
              elevation: 0.0,
              backgroundColor: settingsController.highContrastMode.value
                  ? Colors.black
                  : Colors.white,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    Get.to(() => const Settings());
                  },
                ),
              ],
            )),
      ),
      body: Obx(() => Container(
            color: settingsController.highContrastMode.value
                ? Colors.black
                : Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '여러분을 위한',
                    style: TextStyle(
                      fontSize: 20,
                      color: settingsController.highContrastMode.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    '식품 쇼핑 가이드 앱',
                    style: TextStyle(
                        fontSize: 20,
                        color: settingsController.highContrastMode.value
                            ? Colors.white
                            : Colors.black),
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
                    color: settingsController.highContrastMode.value
                        ? const Color(0xFFFF0000)
                        : const Color(0xffF27979),
                    // onPressed: () async {
                    //   await controller.openCamera();
                    //   if (controller.imageFile.value != null) {
                    //     File imageFile = File(controller
                    //         .imageFile.value!.path); // Convert XFile to File
                    //     Get.to(() => BasicFirst(cameraFile: imageFile));
                    //   }
                    // },
                    onPressed: () {
                      Get.to(() => const BasicFirst());
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ModeButtonWidget(
                    mode: '질병모드',
                    type: ModeButtonType.type2,
                    color: settingsController.highContrastMode.value
                        ? const Color(0xFFFF0000)
                        : const Color(0xffF27979),
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
                    color: settingsController.highContrastMode.value
                        ? const Color(0xFFFF0000)
                        : const Color(0xffF27979),
                    onPressed: () {
                      Get.to(AllergyFirst());
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
