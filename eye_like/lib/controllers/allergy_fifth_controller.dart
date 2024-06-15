import 'package:get/get.dart';

class AllergyFifthController extends GetxController {
  var comment = ''.obs;
  var hasWarnings = false.obs;
  var nutrients = <String>[].obs;
  var mostExtremeMessageType = ''.obs;
  var selectedAllergies = <String>[].obs;

  void setSelectedAllergies(List<String> allergies) {
    selectedAllergies.value = allergies;
  }

  void resetComment() {
    comment.value = '';
    hasWarnings.value = false;
    nutrients.clear();
    mostExtremeMessageType.value = '';
  }

  void updateComment(String nutrient) {
    if (!nutrients.contains(nutrient) && selectedAllergies.contains(nutrient)) {
      nutrients.add(nutrient);
    }
    mostExtremeMessageType.value = 'negative';
    hasWarnings.value = true;
  }

  void finalizeComment() {
    if (hasWarnings.value) {
      comment.value = '해당 제품은 ${nutrients.join(', ')}를 포함하고 있습니다. 알레르기 유발에 조심하세요.';
    } else {
      comment.value = '해당 제품은 알레르기 성분이 없습니다.';
      mostExtremeMessageType.value = 'positive';
    }
  }
}