import 'package:get/get.dart';

class TextCommentController extends GetxController {
  var comment = ''.obs;
  var hasWarnings = false.obs;
  var warningMessages = <String>[].obs;

  void resetComment() {
    comment.value = '';
    hasWarnings.value = false;
    warningMessages.clear();
  }

  void updateComment(String nutrient, String value, String unit) {
    double numericValue = double.tryParse(value) ?? 0;

    // 단위를 통일하여 mg인 경우 g으로 환산
    if (unit == 'mg') {
      numericValue /= 1000;
      unit = 'g';
    }

    String warningMessage = '';

    if (nutrient.contains('지방') &&
        !nutrient.contains('트랜스') &&
        !nutrient.contains('포화') &&
        numericValue > 54) {
      warningMessage =
          '해당 제품은 지방이 너무 많습니다. 과도한 지방 섭취는 체중 증가와 비만으로 이어져 다양한 만성 질환의 위험을 증가시킬 수 있으니 주의하세요.';
    } else if (nutrient.contains('트랜스지방') && numericValue > 15) {
      warningMessage =
          '해당 제품은 트랜스지방이 너무 많습니다. 트랜스지방 보다는 생선, 아보카도, 견과류과 같은 불포화 지방을 섭취하는 것이 어떨까요?';
    } else if (nutrient.contains('포화지방') && numericValue > 15) {
      warningMessage =
          '해당 제품은 포화지방이 너무 많습니다. 포화지방 보다는 생선, 아보카도, 견과류과 같은 불포화 지방을 섭취하는 것이 어떨까요?';
    } else if (nutrient.contains('당류') && numericValue > 100) {
      warningMessage =
          '해당 제품은 당류가 너무 많습니다. 너무 높은 당류의 과도한 칼로리는 과체중과 비만으로 이어질 수 있으니 주의하세요.';
    } else if (nutrient.contains('나트륨') && numericValue > 2) {
      warningMessage =
          '해당 제품은 나트륨이 너무 많습니다. 과도한 나트륨 섭취는 혈압을 상승시켜 고혈압의 주요 원인 중 하나이니 주의하세요.';
    } else if (nutrient.contains('탄수화물') && numericValue > 324) {
      warningMessage =
          '해당 제품은 탄수화물이 너무 많습니다. 과도한 탄수화물 섭취는 과체중과 비만으로 이어질 수 있으니 주의하세요.';
    } else if (nutrient.contains('단백질') && numericValue > 55) {
      warningMessage =
          '해당 제품은 단백질이 너무 많습니다. 과도한 단백질 섭취는 대사과정에서 생성되는 부산물로 인해 몸이 과부하를 겪을 수 있으니 주의하세요.';
    } else if (nutrient.contains('콜레스테롤') && numericValue > 0.3) {
      warningMessage =
          '해당 제품은 콜레스테롤이 너무 많습니다. 과도한 콜레스테롤 섭취는 체내 조절 기능이 어려워지며, 심혈관계 질환의 위험이 높아지니 주의하세요.';
    }

    if (warningMessage.isNotEmpty) {
      warningMessages.add(warningMessage);
      hasWarnings.value = true;
    }
  }

  void finalizeComment() {
    if (hasWarnings.value) {
      comment.value = warningMessages.join('\n');
    } else {
      comment.value = '해당 제품은 적절 함량을 가지고 있습니다.';
    }
  }
}
