import 'package:eye_like/pages/tutorial_second.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialFirst extends StatelessWidget {
  const TutorialFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '여러분을 위한',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  '식품 쇼핑 가이드 앱',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: const Alignment(-0.1, 0), //이미지 가운데 정렬 안되서 추가
                  child: Container(
                    width: 220,
                    height: 200,
                    child: Image.asset('assets/images/main_logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container( //components로 만들어주기
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
          ),
          Container(
            color: Colors.grey.withOpacity(0.5),
            child: Align(
              alignment: const Alignment(0, 0.1), //버튼 가운데 정렬 안되서 추가
              child: Container(
                width: 100,
                height: 50,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {
                    Get.to(const TutorialSecond());
                  },
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
