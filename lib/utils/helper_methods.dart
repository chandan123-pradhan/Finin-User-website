import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class HelperMethods {
  static Future<XFile?> pickImage(ImageSource src) async {
    try {
      XFile? file = await ImagePicker().pickImage(source: src);
      return cropImage(file!);
    } catch (e) {
      return null;
    }
  }

  static Future<XFile?> cropImage(XFile file) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
      );

      if (croppedFile != null) {

        return XFile(croppedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }



  static void shareLink(String link)async{
    final result = await Share.share(link);

if (result.status == ShareResultStatus.success) {
    print('Thank you for sharing my website!');
}
  }
}
