import 'package:eye_like/components/select_button_widget.dart';
import 'package:eye_like/controllers/select_controller_2.dart';
import 'package:eye_like/controllers/setting_controller.dart';
import 'package:eye_like/pages/allergy_fifth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllergyFourth extends StatelessWidget {
  AllergyFourth({super.key});
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
            '이전',
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
        // 선택된 알레르기 성분을 가져옴
        List<String> selectedAllergies = selectController.isSelected.entries
            .where((entry) => entry.value == SelectButtonType.type1)
            .map((entry) => entry.key)
            .toList();

        // AllergyFifth 페이지로 이동하면서 선택된 알레르기 성분을 넘겨줌
        Get.to(() => AllergyFifth(selectedAllergies: selectedAllergies));
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
                  _selectToggleButton('잣'), // 버튼 추후 수정 필요
                  const SizedBox(
                    width: 30,
                  ),
                  SelectButtonWidget(
                    type: SelectButtonType.type3,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectButtonWidget(
                    type: SelectButtonType.type3,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SelectButtonWidget(
                    type: SelectButtonType.type3,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectButtonWidget(
                    type: SelectButtonType.type3,
                  ),
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
