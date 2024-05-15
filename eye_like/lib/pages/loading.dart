import 'dart:async';

import 'package:eye_like/pages/tutorial_first.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget _title() {
  return const Column(
    children: [
      Text(
        '여러분을 위한',
        style: TextStyle(fontSize: 24),
      ),
      Text(
        '식품 쇼핑 가이드 앱',
        style: TextStyle(fontSize: 24),
      ),
    ],
  );
}

Widget _logoimage() {
  return SizedBox(
    height: 160,
    width: 160,
    child: Image.asset('assets/images/loading_logo.png'),
  );
}

Widget _logoname() {
  return SvgPicture.asset('assets/images/loading_title.svg');
}

Widget _loading() {
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
          height: 16,
        ),
        _logoname(),
      ],
    ),
  );
}

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
      body: _loading(),
    );
  }
}
