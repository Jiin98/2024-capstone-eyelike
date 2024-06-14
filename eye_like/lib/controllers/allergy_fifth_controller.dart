import 'package:get/get.dart';

class AllergyFifthController extends GetxController {
  var comment = ''.obs;
  var hasWarnings = false.obs;

  var mostExtremeMessage = ''.obs;
  var mostExtremeMessageType = ''.obs; // 'negative'

  void resetComment() {
    comment.value = '';
    hasWarnings.value = false;
    mostExtremeMessage.value = '';
    mostExtremeMessageType.value = '';
  }

  void updateComment(String nutrient) {
    String message = '해당 제품은 $nutrient를 포함하고 있습니다. 알레르기 유발에 조심하세요.';
    mostExtremeMessage.value = message;
    mostExtremeMessageType.value = 'negative';
    hasWarnings.value = true;
  }

  void finalizeComment() {
    if (hasWarnings.value) {
      comment.value = mostExtremeMessage.value;
    } else {
      comment.value = '해당 제품은 알레르기 성분이 없습니다.';
      mostExtremeMessageType.value = 'positive';
    }
  }
}
