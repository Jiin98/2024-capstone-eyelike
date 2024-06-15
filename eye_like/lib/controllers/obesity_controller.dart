import 'package:get/get.dart';

class ObesityController extends GetxController {
  var comment = ''.obs;
  var hasWarnings = false.obs;
  var positiveMessages = <String>[].obs;
  var negativeMessages = <String>[].obs;

  var mostExtremeMessage = ''.obs;
  var mostExtremeMessageType = ''.obs; // 'positive', 'negative'

  var mostExtremeValue = 0.0;

  void resetComment() {
    comment.value = '';
    hasWarnings.value = false;
    positiveMessages.clear();
    negativeMessages.clear();
    mostExtremeMessage.value = '';
    mostExtremeMessageType.value = '';
    mostExtremeValue = 0.0;
  }

  void updateComment(String nutrient, String value, String unit) {
    double numericValue = double.tryParse(value) ?? 0;

    // 단위를 통일하여 mg인 경우 g으로 환산
    if (unit == 'mg') {
      numericValue /= 1000;
      unit = 'g';
    }

    if (unit == 'g') {
      if (nutrient.contains('당류')) {
        if (numericValue < 0.5) {
          _updateMessage(
              '해당 제품은 당이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 5) {
          _updateMessage('해당 제품은 저당식품으로 칼로리 섭취가 감소하여 비만 관리에 도움이 될 수 있습니다.',
              numericValue, 'positive');
        } else if (numericValue >= 10) {
          _updateMessage(
              '해당 제품은 당이 매우 많습니다. 당이 높은 음식은 칼로리가 높아 체중 관리에 부정적이니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient == '지방') {
        // 트랜스지방, 포화지방과 구분
        if (numericValue < 0.5) {
          _updateMessage(
              '해당 제품은 지방이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 3) {
          _updateMessage('해당 제품은 저지방 식품으로 체중 감량에 유리하여 비만 관리에 도움이 될 수 있습니다.',
              numericValue, 'positive');
        } else if (numericValue >= 20) {
          _updateMessage(
              '해당 제품은 지방이 매우 많습니다. 지방이 많은 음식은 칼로리가 높아 체중 관리에 부정적이니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('열량') || nutrient.contains('칼로리')) {
        if (numericValue < 4) {
          _updateMessage(
              '해당 제품은 열량이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 40) {
          _updateMessage(
              '해당 제품은 저칼로리식품으로 비만 관리에 도움이 될 수 있습니다.', numericValue, 'positive');
        } else if (numericValue >= 275) {
          _updateMessage(
              '해당 제품은 열량이 너무 많습니다. 과다한 열량 섭취는 체내에 저장되어 체중 관리에 부정적이니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('섬유질') || nutrient.contains('식이섬유')) {
        if (numericValue >= 6) {
          _updateMessage(
              '해당 제품은 섬유질이 매우 많습니다. 섬유질은 포만감을 증가시켜 비만 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 3) {
          _updateMessage(
              '해당 제품은 식이섬유를 함유하고 있습니다. 식이섬유를 식사 전에 섭취하면 혈당 스파이크를 예방해 살이 찌기 쉬운 체질로 변하는 것을 예방할 수 있습니다.',
              numericValue,
              'positive');
        }
      }
    } else if (unit == 'ml') {
      if (nutrient.contains('당류')) {
        if (numericValue < 0.25) {
          _updateMessage(
              '해당 제품은 당이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 2.5) {
          _updateMessage('해당 제품은 저당식품으로 칼로리 섭취가 감소하여 비만 관리에 도움이 될 수 있습니다.',
              numericValue, 'positive');
        } else if (numericValue >= 10) {
          _updateMessage(
              '해당 제품은 당이 매우 많습니다. 당이 높은 음식은 칼로리가 높아 체중 관리에 부정적이니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient == '지방') {
        if (numericValue < 0.5) {
          _updateMessage(
              '해당 제품은 지방이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 1.5) {
          _updateMessage('해당 제품은 저지방 식품으로 체중 감량에 유리하여 비만 관리에 도움이 될 수 있습니다.',
              numericValue, 'positive');
        } else if (numericValue >= 20) {
          _updateMessage(
              '해당 제품은 지방이 매우 많습니다. 지방이 많은 음식은 칼로리가 높아 체중 관리에 부정적이니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('열량') || nutrient.contains('칼로리')) {
        if (numericValue < 4) {
          _updateMessage(
              '해당 제품은 열량이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 20) {
          _updateMessage(
              '해당 제품은 저칼로리식품으로 비만 관리에 도움이 될 수 있습니다.', numericValue, 'positive');
        } else if (numericValue >= 275) {
          _updateMessage(
              '해당 제품은 열량이 너무 많습니다. 과다한 열량 섭취는 체내에 저장되어 체중 관리에 부정적이니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('섬유질') || nutrient.contains('식이섬유')) {
        if (numericValue >= 3) {
          _updateMessage(
              '해당 제품은 섬유질이 매우 많습니다. 섬유질은 포만감을 증가시켜 비만 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 1.5) {
          _updateMessage(
              '해당 제품은 식이섬유를 함유하고 있습니다. 식이섬유를 식사 전에 섭취하면 혈당 스파이크를 예방해 살이 찌기 쉬운 체질로 변하는 것을 예방할 수 있습니다.',
              numericValue,
              'positive');
        }
      }
    }

    hasWarnings.value =
        positiveMessages.isNotEmpty || negativeMessages.isNotEmpty;
  }

  void _updateMessage(String message, double value, String type) {
    if (type == 'positive') {
      positiveMessages.add(message);
    } else if (type == 'negative') {
      negativeMessages.add(message);
    }

    if (value > mostExtremeValue) {
      mostExtremeValue = value;
      mostExtremeMessage.value = message;
      mostExtremeMessageType.value = type;
    }
  }

  void finalizeComment() {
    if (hasWarnings.value) {
      comment.value = mostExtremeMessage.value;
    } else {
      comment.value = '해당 제품은 적절 함량을 가지고 있습니다.';
    }
  }
}
