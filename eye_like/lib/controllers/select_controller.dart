import 'package:get/get.dart';
import 'package:eye_like/components/select_button_widget.dart';

class SelectController extends GetxController {
  final RxMap<String, SelectButtonType> allergens = { //코드가 어떤 의미인지 알아봐야함
    '난류': SelectButtonType.type2,
    '우유': SelectButtonType.type2,
    '메밀': SelectButtonType.type2,
    '땅콩': SelectButtonType.type2,
    '대두': SelectButtonType.type2,
    '밀': SelectButtonType.type2,
    '고등어': SelectButtonType.type2,
    '게': SelectButtonType.type2,
    '새우': SelectButtonType.type2,
    '돼지고기': SelectButtonType.type2,
    '복숭아': SelectButtonType.type2,
    '토마토': SelectButtonType.type2,
    '호두': SelectButtonType.type2,
    '닭고기': SelectButtonType.type2,
    '쇠고기': SelectButtonType.type2,
    '아황산류': SelectButtonType.type2,
    '오징어': SelectButtonType.type2,
    '조개': SelectButtonType.type2,
    '잣': SelectButtonType.type2,
  }.obs;

  void toggleAllergenType(String allergen) {
    allergens[allergen] = allergens[allergen] == SelectButtonType.type2 ? SelectButtonType.type1 : SelectButtonType.type2;
  }
}