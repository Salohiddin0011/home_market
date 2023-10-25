import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

sealed class StoreService {
  static final storage = FirebaseStorage.instance;

  static Future<String> uploadFile(File file, String id) async {
    final image = storage.ref(id).child(
        "image_${DateTime.now().toIso8601String()}${file.path.substring(file.path.lastIndexOf("."))}");
    final task = image.putFile(file);
    await task.whenComplete(() {});
    return image.getDownloadURL();
  }

  static Future<void> removeFiles(String id) async {
    final images = storage.ref(id);

    await images.delete();
  }
}
