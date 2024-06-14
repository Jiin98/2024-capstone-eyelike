import 'package:eye_like/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SelectButtonType { type1, type2, type3 }

class SelectButtonWidget extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());

  // StatelessWidget은 불변성을 지닌 클래스이므로, StatelessWidget의 모든 인스턴스는 final 선언
  final VoidCallback? onPressed;
  final String? name; // ?는 null값을 가질 수 있음을 의미
  final SelectButtonType type;

  Color _getColor(SelectButtonType type) {
    switch (type) {
      case SelectButtonType.type1:
        return settingsController.highContrastMode.value
            ? const Color(0xffFFFF00)
            : const Color(0xffD9C55F);
      case SelectButtonType.type2:
        return settingsController.highContrastMode.value
            ? const Color(0xFFFF0000)
            : const Color(0xffF27979);
      case SelectButtonType.type3:
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

   SelectButtonWidget({
    Key? key,
    this.onPressed,
    this.name,
    required this.type,
  }) : super(key: key);

  Widget type1widget() {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed, //onpressed에 대한 값을 받도록 설정
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: _getColor(SelectButtonType.type1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name ?? '', //name이 nullable할 때, ?? 연산자를 사용하면, null일 때, 반환값 설정할 수 있음
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget type2widget() {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: _getColor(SelectButtonType.type2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget type3widget() {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: _getColor(SelectButtonType.type3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name ?? '',
            style: const TextStyle(
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
    switch (type) {
      case SelectButtonType.type1:
        return type1widget();
      case SelectButtonType.type2:
        return type2widget();
      case SelectButtonType.type3:
        return type3widget();
    }
  }
}
