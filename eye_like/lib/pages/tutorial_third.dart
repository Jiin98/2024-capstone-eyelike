import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialThird extends StatelessWidget {
  const TutorialThird({super.key});

  Widget _background() {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Image.asset('assets/images/main_logo.png'),
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
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          _background(),
          Stack(
            children: [
              _overlay(),
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
