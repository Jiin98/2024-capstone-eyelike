import 'package:eye_like/pages/tutorial_third.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialSecond extends StatelessWidget {
  const TutorialSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text('TutorialSecond'),
          ),
          Container(
            color: Colors.grey.withOpacity(0.5),
            child: Align(
              alignment: const Alignment(0, 0.1),
              child: Container(
                width: 100,
                height: 50,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {
                    Get.to(const TutorialThird());
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
