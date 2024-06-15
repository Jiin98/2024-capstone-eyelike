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
  return SizedBox(
    width: 220,
    height: 200,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0), //image 가운데 정렬
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
        Container(
          width: 280,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffD9C55F),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              '기본모드',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: 280,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffF27979),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              '질병모드',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: 280,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffF27979),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              '알레르기모드',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
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
  return Center(
    child: Transform.translate(
      // UI 정중앙에 배치 후, 위치 조정
      offset: const Offset(0, 100),
      child: const Column(
        children: [
          Text(
            'EYE조아',
            style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w700,
                fontFamily: 'Cafe24 Ssurround'),
          ),
          Text(
            '사용가이드',
            style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w700,
                fontFamily: 'Cafe24 Ssurround'),
          ),
        ],
      ),
    ),
  );
}

Widget _body() {
  return Center(
    child: Transform.translate(
      offset: const Offset(75, 10),
      child: const Text(
        '나에게 맞는\n모드를 선택해요!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            fontFamily: 'Cafe24 SsurroundAir'),
      ),
    ),
  );
}

Widget _body2() {
  return Center(
    child: Transform.translate(
      offset: const Offset(50, 65),
      child: const Text(
        '모드마다 읽어주는 정보가\n조금씩 달라요!',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'KyoboHandwriting2020'),
      ),
    ),
  );
}

Widget _previousButton() {
  return IconButton(
    onPressed: () {
      Get.back();
    },
    icon: Image.asset('assets/images/previous_button.png'),
  );
}

Widget _nextButton() {
  return IconButton(
    onPressed: () {
      Get.to(const TutorialSecond());
    },
    icon: Image.asset('assets/images/next_button.png'),
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
              Container(
                alignment: const Alignment(0, 0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //가로축 중앙정렬
                  children: [
                    _previousButton(),
                    const SizedBox(
                      width: 200,
                    ),
                    _nextButton(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
