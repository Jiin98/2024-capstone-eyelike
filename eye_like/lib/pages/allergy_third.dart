import 'package:eye_like/components/select_button_widget.dart';
import 'package:eye_like/controllers/select_controller.dart';
import 'package:eye_like/pages/allergy_fourth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllergyThird extends StatelessWidget {
  AllergyThird({super.key});
  final SelectController selectController = Get.put(SelectController());

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
      onPressed: () {
        Get.to(AllergyFourth());
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
              _selectToggleButton('호두'),
              const SizedBox(
                width: 30,
              ),
              _selectToggleButton('닭고기'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selectToggleButton('쇠고기'),
              const SizedBox(
                width: 30,
              ),
              _selectToggleButton('아황산류'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selectToggleButton('오징어'),
              const SizedBox(
                width: 30,
              ),
              _selectToggleButton('조개'),
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
