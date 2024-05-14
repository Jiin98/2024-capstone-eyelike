import 'dart:async';

import 'package:eye_like/pages/tutorial_first.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const TutorialFirst()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '여러분을 위한',
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              '식품 쇼핑 가이드 앱',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              height: 160,
              width: 160,
              child: Image.asset('assets/images/loading_logo.png'),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              child: SvgPicture.asset('assets/images/loading_title.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
