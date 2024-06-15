import 'package:get/get.dart';

class DiabetesController extends GetxController {
  var comment = ''.obs;
  var hasWarnings = false.obs;
  var positiveMessages = <String>[].obs;
  var negativeMessages = <String>[].obs;

  var mostExtremeMessage = ''.obs;
  var mostExtremeMessageType = ''.obs;

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

    if (unit == 'mg') {
      numericValue /= 1000;
      unit = 'g';
    }

    if (unit == 'g') {
      if (nutrient.contains('당류')) {
        if (numericValue < 0.5) {
          _updateMessage(
              '해당 제품은 당이 거의 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 5) {
          _updateMessage(
              '해당 제품은 저당식품으로 혈당 관리에 도움이 될 수 있습니다. 하지만, 과도 섭취 시 부정적인 영향을 끼칠 수 있으니 적당량을 섭취하는 것이 중요합니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 10) {
          _updateMessage('해당 제품은 당이 매우 많습니다. 당이 높은 음식은 혈당 수치를 급격히 증가시키니 주의하세요.',
              numericValue, 'negative');
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
              '해당 제품은 섬유질이 매우 많습니다. 섬유질은 혈당 수치를 안정화시키는데 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 3) {
          _updateMessage(
              '해당 제품은 식이섬유를 함유하고 있습니다. 식이섬유를 식사 전에 섭취하면 혈당 스파이크를 예방해 살이 찌기 쉬운 체질로 변하는 것을 예방할 수 있습니다.',
              numericValue,
              'positive');
        }
      } else if (nutrient == '나트륨') {
        if (numericValue < 0.05) {
          _updateMessage(
              '해당 제품은 나트륨이 거의 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 0.12) {
          _updateMessage(
              '해당 제품은 나트륨이 매우 적습니다. 나트륨이 적은 음식은 혈압 상승을 방지하여 심혈관 질환의 위험을 줄여줍니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 0.5) {
          _updateMessage(
              '해당 제품은 나트륨이 매우 많습니다. 나트륨이 높은 음식은 혈압이 상승하여 당뇨병과 관련된 심혈관 질환의 위험이 증가하니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('포화지방')) {
        if (numericValue < 0.1) {
          _updateMessage(
              '해당 제품은 포화지방이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 1.5) {
          _updateMessage(
              '해당 제품은 포화지방이 매우 적습니다. 포화지방이 적은 음식은 인슐린 저항성을 감소시켜 혈당 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 4) {
          _updateMessage(
              '해당 제품은 포화지방이 매우 많습니다. 포화지방이 높은 음식은 인슐린 저항성을 증가시키니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('트랜스지방')) {
        if (numericValue < 0.5) {
          _updateMessage(
              '해당 제품은 트랜스지방이 매우 적습니다. 트랜스지방이 적은 음식은 인슐린 저항성을 감소시켜 혈당 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 2) {
          _updateMessage(
              '해당 제품은 트랜스지방이 매우 많습니다. 트랜스지방이 높은 음식은 당뇨병과 관련된 심혈관 질환의 위험이 증가하니 주의하세요.',
              numericValue,
              'negative');
        }
      }
    } else if (unit == 'ml') {
      if (nutrient.contains('당류')) {
        if (numericValue < 0.25) {
          _updateMessage(
              '해당 제품은 당이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 2.5) {
          _updateMessage(
              '해당 제품은 저당식품으로 혈당 관리에 도움이 될 수 있습니다.', numericValue, 'positive');
        } else if (numericValue >= 10) {
          _updateMessage('해당 제품은 당이 매우 많습니다. 당이 높은 음식은 혈당 수치를 급격히 증가시키니 주의하세요.',
              numericValue, 'negative');
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
              '해당 제품은 섬유질이 매우 많습니다. 섬유질은 혈당 수치를 안정화시키는데 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 1.5) {
          _updateMessage(
              '해당 제품은 식이섬유를 함유하고 있습니다. 식이섬유를 식사 전에 섭취하면 혈당 스파이크를 예방해 살이 찌기 쉬운 체질로 변하는 것을 예방할 수 있습니다.',
              numericValue,
              'positive'); // 추가정보가 긍정 또는 부정으로 묶이면 제거
        }
      } else if (nutrient == '나트륨') {
        if (numericValue < 0.05) {
          _updateMessage(
              '해당 제품은 나트륨이 거의 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 0.12) {
          _updateMessage(
              '해당 제품은 나트륨이 매우 적습니다. 나트륨이 적은 음식은 혈압 상승을 방지하여 심혈관 질환의 위험을 줄여줍니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 0.5) {
          _updateMessage(
              '해당 제품은 나트륨이 매우 많습니다. 나트륨이 높은 음식은 혈압이 상승하여 당뇨병과 관련된 심혈관 질환의 위험이 증가하니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('포화지방')) {
        if (numericValue < 0.1) {
          _updateMessage(
              '해당 제품은 포화지방이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 0.75) {
          _updateMessage(
              '해당 제품은 포화지방이 매우 적습니다. 포화지방이 적은 음식은 인슐린 저항성을 감소시켜 혈당 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 4) {
          _updateMessage(
              '해당 제품은 포화지방이 매우 많습니다. 포화지방이 높은 음식은 인슐린 저항성을 증가시키니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('트랜스지방')) {
        if (numericValue < 0.5) {
          _updateMessage(
              '해당 제품은 트랜스지방이 매우 적습니다. 트랜스지방이 적은 음식은 인슐린 저항성을 감소시켜 혈당 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 2) {
          _updateMessage(
              '해당 제품은 트랜스지방이 매우 많습니다. 트랜스지방이 높은 음식은 당뇨병과 관련된 심혈관 질환의 위험이 증가하니 주의하세요.',
              numericValue,
              'negative');
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
