import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier{

  ImagePicker picker = ImagePicker();
  XFile? image;

  void openCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    notifyListeners();
  }

  void openGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }
}