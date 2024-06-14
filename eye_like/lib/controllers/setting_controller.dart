import 'package:get/get.dart';

class SettingsController extends GetxController {
  var highContrastMode = false.obs;

  void toggleHighContrastMode() {
    highContrastMode.value = !highContrastMode.value;
  }
}