import 'package:eye_like/components/select_button_widget.dart';
import 'package:eye_like/controllers/select_controller_2.dart';
import 'package:eye_like/controllers/setting_controller.dart';
import 'package:eye_like/pages/allergy_second.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllergyFirst extends StatelessWidget {
  AllergyFirst({super.key});
  final SelectController2 selectController = Get.put(SelectController2());
  final SettingsController settingsController = Get.put(SettingsController());

  Widget _selectToggleButton(String name) {
    return Obx(() => SelectButtonWidget(
          name: name,
          type: selectController.isSelected[name]!,
          onPressed: () => selectController.toggleIsSelected(name),
        ));
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
          color: settingsController.highContrastMode.value
              ? const Color(0xff00FF00)
              : const Color(0xff30D979),
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
      onPressed: () {
        Get.to(AllergySecond());
      }, //onpressed에 대한 값을 받도록 설정
      child: Container(
        width: 110,
        height: 60,
        decoration: BoxDecoration(
          color: settingsController.highContrastMode.value
              ? const Color(0xff00FF00)
              : const Color(0xff30D979),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            '다음',
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
      body: Obx(
        () => Container(
          color: settingsController.highContrastMode.value
              ? Colors.black
              : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
                child: Image.asset('assets/images/main_logo.png'),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectToggleButton('난류'),
                  const SizedBox(
                    width: 30,
                  ),
                  _selectToggleButton('우유'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectToggleButton('메밀'),
                  const SizedBox(
                    width: 30,
                  ),
                  _selectToggleButton('땅콩'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectToggleButton('대두'),
                  const SizedBox(
                    width: 30,
                  ),
                  _selectToggleButton('밀'),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
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
        ),
      ),
    );
  }
}
