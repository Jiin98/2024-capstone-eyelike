import 'package:get/get.dart';

class SettingsController extends GetxController {
  var highContrastMode = false.obs;
  var fontSize = 22.0.obs;

  void toggleHighContrastMode() {
    highContrastMode.value = !highContrastMode.value;
  }

  void updateFontSize(double size) {
    fontSize.value = size;
  }
}
