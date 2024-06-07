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
        text += '${block.text}\n';
    }

    textRecognizer.close();
    return text;
  }
}
