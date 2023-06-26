import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString dropdownValue = 'post'.obs;
  Rx<TextEditingController> mediaLinkController = TextEditingController().obs;
  Rx<TextEditingController> videoThumbnaiController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

   hasValidUrl(String value) {
    String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter url';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid url';
    }
    return null;
  }
  Future<String> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      return result.files.single.path!;
    } else {
      throw Exception('No video file selected.');
    }
  }
}