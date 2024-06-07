import 'package:get/get.dart';
import 'package:eye_like/components/select_button_widget.dart';

class SelectController1 extends GetxController {
  final RxMap<String, SelectButtonType> isSelected = {
    // Map은 key: value형태의 자료형
    '당뇨병': SelectButtonType.type2,
    '고혈압': SelectButtonType.type2,
    '비만': SelectButtonType.type2,
    '암': SelectButtonType.type2,
    '뇌졸증': SelectButtonType.type2,
  }.obs;

  void toggleIsSelected(String name) {
    // 버튼이 눌려지면, key값을 받아오고, 해당 value인 type을 확인한 후, type 변환
    isSelected[name] = isSelected[name] == SelectButtonType.type2
        ? SelectButtonType.type1
        : SelectButtonType.type2;
  }
}
