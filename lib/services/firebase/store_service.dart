import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:home_market/services/firebase/db_service.dart';

sealed class StoreService {
  static final storage = FirebaseStorage.instance;

  static Future<String> uploadFile(File file) async {
    final image = storage.ref(Folder.postImages).child(
        "image_${DateTime.now().toIso8601String()}${file.path.substring(file.path.lastIndexOf("."))}");
    final task = image.putFile(file);
    await task.whenComplete(() {});
    return image.getDownloadURL();
  }

  static Future<void> removeFiles(List<String> imagePath) async {
    for (var i = 0; i < imagePath.length; i++) {
      var fileUrl = Uri.decodeFull(path.basename(imagePath[i]))
          .replaceAll(RegExp(r'(\?alt).*'), '');
      final storeReference = storage.ref().child(fileUrl);
      await storeReference.delete();
    }
  }
}
