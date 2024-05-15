import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialThird extends StatelessWidget {
  const TutorialThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text('TutorialThird'),
          ),
          Stack(
            children: [
              Container(
                color: Colors.grey.withOpacity(0.8),
              ),
              Container(
                alignment: const Alignment(0, 0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Center(
                          child: Text(
                            'Previous',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
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
