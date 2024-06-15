import 'package:get/get.dart';

class HighBloodPressureController extends GetxController {
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
      if (nutrient == '나트륨') {
        if (numericValue < 0.005) {
          _updateMessage(
              '해당 제품은 나트륨이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 0.12) {
          _updateMessage(
              '해당 제품은 나트륨이 매우 적습니다. 나트륨이 적은 음식은 혈압 상승을 방지하여 고혈압 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 0.5) {
          _updateMessage(
              '해당 제품은 나트륨이 매우 많습니다. 나트륨이 높은 음식은 체내 수분이 증가하여 고혈압을 유발하니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('포화지방')) {
        if (numericValue < 0.1) {
          _updateMessage(
              '해당 제품은 포화지방이 없으므로, 안심하고 드셔도 좋습니다.', numericValue, 'positive');
        } else if (numericValue < 1.5) {
          _updateMessage(
              '해당 제품은 포화지방이 매우 적습니다. 포화지방이 적은 음식은 혈압을 안정시켜주어 고혈압 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 4) {
          _updateMessage(
              '해당 제품은 포화지방이 매우 많습니다. 포화지방이 높은 음식은 혈액 내 콜레스테롤 수치를 증가시키니 주의하세요.',
              numericValue,
              'negative');
        }
      } else if (nutrient.contains('트랜스지방')) {
        if (numericValue < 0.5) {
          _updateMessage(
              '해당 제품은 트랜스지방이 매우 적습니다. 트랜스지방이 적은 음식은 혈관 염증과 동맥 경화 위험을 줄여 고혈압 관리에 도움이 될 수 있습니다.',
              numericValue,
              'positive');
        } else if (numericValue >= 2) {
          _updateMessage(
              '해당 제품은 트랜스지방이 매우 많습니다. 트랜스지방이 높은 음식은 동맥을 경화시켜 심혈관 건강을 해치니 주의하세요.',
              numericValue,
              'negative');
        }
      }
    } else if (unit == 'ml') {
      if (nutrient.contains('카페인')) {
        if (numericValue >= 0.15) {
          _updateMessage('해당 제품은 고카페인을 함유하고 있습니다. 뇌졸증 위험을 높히니 섭취에 주의하세요.',
              numericValue, 'negative');
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
