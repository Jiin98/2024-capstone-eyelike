import 'package:get/get.dart';
import 'package:eye_like/components/select_button_widget.dart';

class SelectController1 extends GetxController {
  final RxMap<String, SelectButtonType> isSelected = {
    // Map은 key: value형태의 자료형
    '당뇨병': SelectButtonType.type2,
    '고혈압': SelectButtonType.type2,
    '비만': SelectButtonType.type2,
  }.obs;

  void toggleIsSelected(String name) {
    // 모든 버튼을 type2로 초기화
    isSelected.updateAll((key, value) => SelectButtonType.type2);

    // 선택된 버튼만 type1으로 설정
    isSelected[name] = SelectButtonType.type1;
  }

  void resetSelections() {
    isSelected.updateAll((key, value) => SelectButtonType.type2);
  }
}
