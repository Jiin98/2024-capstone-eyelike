import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> imageFile = Rx<XFile?>(null);

  Future<void> openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imageFile.value = image;
    }
  }
}
