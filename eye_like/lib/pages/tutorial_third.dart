import 'package:eye_like/pages/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialThird extends StatefulWidget {
  const TutorialThird({super.key});

  @override
  State<TutorialThird> createState() => _TutorialThirdState();
}

class _TutorialThirdState extends State<TutorialThird> {
  bool switchValue1 = false; // Switch에서 사용
  bool switchValue2 = true; // Switch에서 사용
  double currentValue = 24.0; // Silder에서 사용

  Widget _background() {
    return Center(
      child: Transform.translate(
        offset: const Offset(0, 80),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Image.asset('assets/images/main_logo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '고대비 모드',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Segoe UI',
                    ),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: switchValue1,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value) {
                      setState(
                        () {
                          switchValue1 =
                              value ?? false; // ??는 null일 경우 처리를 위한 연산자
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 36,
              thickness: 0.8,
              color: Color(0xff454545),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '음성',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Segoe UI',
                    ),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: switchValue2,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value) {
                      setState(
                        () {
                          switchValue2 = value ?? false;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 36,
              thickness: 0.8,
              color: Color(0xff454545),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity, // 부모 위젯의 최대 너비를 차지
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '글자 크기',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          '가',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Segoe UI',
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: CupertinoColors.activeGreen,
                            inactiveColor: CupertinoColors.secondarySystemFill,
                            value: currentValue,
                            min: 20, // 임의값
                            max: 32, // 임의값
                            onChanged: (value) => setState(
                              () {
                                currentValue = value;
                              },
                            ),
                          ),
                        ),
                        const Text(
                          '가',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Segoe UI',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 36,
              thickness: 0.8,
              color: Color(0xff454545),
            ),
          ],
        ),
      ),
    );
  }

  Widget _overlay() {
    return Container(
      color: Colors.grey.withOpacity(0.8),
    );
  }

  Widget _body() {
    return Center(
      child: Transform.translate(
        offset: const Offset(60, -220),
        child: const Text(
          '고대비 모드를 켜면!',
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
        offset: const Offset(10, -180),
        child: const Text(
          '화면이 어두워지고\n글의 시인성이 높아져요!',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'KyoboHandwriting2020'),
        ),
      ),
    );
  }

  Widget _body3() {
    return Center(
      child: Transform.translate(
        offset: const Offset(100, -50),
        child: const Text(
          '음성을 끄면!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              fontFamily: 'Cafe24 SsurroundAir'),
        ),
      ),
    );
  }

  Widget _body4() {
    return Center(
      child: Transform.translate(
        offset: const Offset(100, -10),
        child: const Text(
          '추출한 정보를\n음성으로 내보내지 않아요!',
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
        Get.to(const App());
      },
      icon: Image.asset('assets/images/next_button.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
