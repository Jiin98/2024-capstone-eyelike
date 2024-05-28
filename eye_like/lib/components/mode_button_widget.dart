import 'package:flutter/material.dart';

enum ModeButtonType { type1, type2 }

class ModeButtonWidget extends StatelessWidget {
  // StatelessWidget은 불변성을 지닌 클래스이므로, StatelessWidget의 모든 인스턴스는 final 선언
  final VoidCallback? onPressed;
  final String mode; // ?는 null값을 가질 수 있음을 의미
  final ModeButtonType type;

  const ModeButtonWidget({
    Key? key,
    this.onPressed,
    required this.mode,
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
        width: 280,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffD9C55F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            mode, //mode이 nullable할 때, ?? 연산자를 사용하면, null일 때, 반환값 설정할 수 있음
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
        width: 280,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffF27979),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            mode,
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
      case ModeButtonType.type1:
        return type1widget();
      case ModeButtonType.type2:
        return type2widget();
    }
  }
}
