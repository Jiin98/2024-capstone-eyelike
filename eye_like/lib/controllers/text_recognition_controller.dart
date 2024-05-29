import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionService {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);

  Future<String> recognizeTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = '';
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          text += '${element.text}\n';
        }
      }
    }

    // String text = '';
    // for (TextBlock block in recognizedText.blocks) {
    //   for (TextLine line in block.lines) {
    //     for (TextElement element in line.elements) {
    //       text += '${element.text} ';  // 각 element 뒤에 공백을 추가하여 구분
    //     }
    //     text += '\n';  // 각 줄의 끝에 줄바꿈 문자 추가
    //   }
    // }

    textRecognizer.close();
    return text;
  }
}
