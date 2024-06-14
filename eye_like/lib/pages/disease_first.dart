import 'package:eye_like/controllers/select_controller_1.dart';
import 'package:eye_like/components/select_button_widget.dart';
import 'package:eye_like/controllers/setting_controller.dart';
import 'package:eye_like/pages/diabetes_first.dart';
import 'package:eye_like/pages/high_blood_pressure_first.dart';
import 'package:eye_like/pages/obesity_first.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseFirst extends StatelessWidget {
  DiseaseFirst({super.key});
  final SelectController1 selectController = Get.put(SelectController1());
  final SettingsController settingsController = Get.put(SettingsController());

  Widget _selectToggleButton(String name) {
    return Obx(() => SelectButtonWidget(
          // Obx를 통해 상태 변화를 감지하고, 상태 변화가 일어나면 즉시 UI 업데이트
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
        selectController.resetSelections();
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
        if (selectController.isSelected['당뇨병'] == SelectButtonType.type1) {
          Get.to(const Diabetes());
        } else if (selectController.isSelected['고혈압'] ==
            SelectButtonType.type1) {
          Get.to(const HighBloodPressure());
        } else if (selectController.isSelected['비만'] ==
            SelectButtonType.type1) {
          Get.to(const Obesity());
        }
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
                  _selectToggleButton('당뇨병'),
                  const SizedBox(
                    width: 30,
                  ),
                  _selectToggleButton('고혈압'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectToggleButton('비만'),
                  const SizedBox(
                    width: 30,
                  ),
                  SelectButtonWidget(
                    type: SelectButtonType.type3,
                  ),
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
