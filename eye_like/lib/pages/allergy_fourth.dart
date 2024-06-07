import 'package:eye_like/components/select_button_widget.dart';
import 'package:eye_like/controllers/select_controller_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllergyFourth extends StatelessWidget {
  AllergyFourth({super.key});
  final SelectController2 selectController = Get.put(SelectController2());

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
          color: const Color(0xff30D979),
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
      onPressed: () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selectToggleButton('잣'), // 버튼 추후 수정 필요
              const SizedBox(
                width: 30,
              ),
              const SelectButtonWidget(type: SelectButtonType.type3),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectButtonWidget(type: SelectButtonType.type3),
              SizedBox(
                width: 30,
              ),
              SelectButtonWidget(type: SelectButtonType.type3),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectButtonWidget(type: SelectButtonType.type3),
              SizedBox(
                width: 30,
              ),
              SelectButtonWidget(type: SelectButtonType.type3),
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
    );
  }
}
