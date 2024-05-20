import 'package:eye_like/pages/tutorial_third.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialSecond extends StatelessWidget {
  const TutorialSecond({super.key});

  Widget _background() {
    return Center(
      child: Image.asset('assets/images/tutorial_camera.png'),
    );
  }

  Widget _overlay() {
    return Container(
      color: Colors.grey.withOpacity(0.8),
    );
  }

  Widget _body() {
    return const Positioned(
      top: 180,
      left: 170,
      child: Text(
        '설정에 들어가면!',
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
      top: 220,
      left: 170,
      child: Text(
        '고대비 모드 on/off, 음성 on/off 등\n다양한 설정이 가능해요!',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'KyoboHandwriting2020'),
      ),
    );
  }

  Widget _body3() {
    return const Positioned(
      top: 540,
      left: 190,
      child: Text(
        '식품 라벨\n사진을 찍으면!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            fontFamily: 'Cafe24 SsurroundAir'),
      ),
    );
  }

  Widget _body4() {
    return const Positioned(
      top: 620,
      left: 190,
      child: Text(
        '필요한 정보만 추출해서 읽어줘요!',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'KyoboHandwriting2020'),
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
        Get.to(const TutorialThird());
      },
      icon: Image.asset('assets/images/next_button.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          Stack(
            children: [
              _overlay(),
              _body(),
              _body2(),
              _body3(),
              _body4(),
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
          ),
        ],
      ),
    );
  }
}
