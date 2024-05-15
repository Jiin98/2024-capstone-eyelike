import 'package:eye_like/components/mode_button_widget.dart';
import 'package:eye_like/pages/tutorial_second.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget _title() {
  return const Column(
    children: [
      Text(
        '여러분을 위한',
        style: TextStyle(fontSize: 20),
      ),
      Text(
        '식품 쇼핑 가이드 앱',
        style: TextStyle(fontSize: 20),
      ),
    ],
  );
}

Widget _logoimage() {
  return Align(
    alignment: const Alignment(-0.1, 0), //이미지 가운데 정렬 안돼서 추가
    child: SizedBox(
      width: 220,
      height: 200,
      child: Image.asset('assets/images/main_logo.png'),
    ),
  );
}

Widget _background() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _title(),
        const SizedBox(
          height: 24,
        ),
        _logoimage(),
        const SizedBox(
          height: 24,
        ),
        const ModeButtonWidget(
          modename: '기본모드',
          type: ModeButtonType.type1,
        ),
        const SizedBox(
          height: 16,
        ),
        const ModeButtonWidget(
          modename: '질병모드',
          type: ModeButtonType.type2,
        ),
        const SizedBox(
          height: 16,
        ),
        const ModeButtonWidget(
          modename: '알레르기모드',
          type: ModeButtonType.type2,
        ),
      ],
    ),
  );
}

Widget _overlay() {
  return Container(
    color: Colors.grey.withOpacity(0.8),
  );
}

Widget _header() {
  return const Positioned(
    top: 120,
    left: 100,
    child: Column(
      children: [
        Text(
          'EYE조아',
          style: TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cafe24 Ssurround'),
        ),
        Text(
          '사용가이드',
          style: TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _body() {
  return const Positioned(
    top: 400,
    left: 150,
    child: Text(
      '나에게 맞는\n모드를 선택해요!',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w300,
          fontFamily: 'Cafe24 SsurroundAir'),
    ),
  );
}

Widget _body2() {
  return const Positioned(
    top: 470,
    left: 150,
    child: Text(
      '모드마다 읽어주는 정보가\n조금씩 달라요!',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'KyoboHandwriting2020'),
    ),
  );
}

Widget _button() {
  return Container(
    alignment: const Alignment(0.5, 0.8), //버튼 가운데 정렬 안돼서 추가
    child: IconButton(
        onPressed: () {
          Get.to(const TutorialSecond());
        },
        icon: Image.asset('assets/images/next_button.png')),
  );
}

class TutorialFirst extends StatelessWidget {
  const TutorialFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //double stack을 통한 3 layers 구현
        children: [
          _background(),
          Stack(
            children: [
              _overlay(),
              _header(),
              _body(),
              _body2(),
              _button(),
            ],
          )
        ],
      ),
    );
  }
}
