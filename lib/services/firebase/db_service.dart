import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:home_market/models/message_model.dart';
import 'package:home_market/models/post_model.dart';
import 'package:home_market/models/user_model.dart';
import 'package:home_market/services/firebase/auth_service.dart';
import 'package:home_market/services/firebase/store_service.dart';

sealed class DBService {
  static final db = FirebaseDatabase.instance;

  /// post
  static Future<bool> storePost(
      {required String title,
      required String content,
      required bool isPublic,
      required File file,
      required bool carPark,
      required bool swimming,
      required bool gym,
      required bool restaurant,
      required bool wifi,
      required bool petCenter,
      required bool medicalCentre,
      required bool school,
      required String area,
      required String bathrooms,
      required bool isApartment,
      required String phone,
      required String price,
      required String rooms,
      required List<File?> gridImages}) async {
    try {
      print("try");
      final folder = db.ref(Folder.post);
      print("try1");
      final child = folder.push();
      print("try2");
      final id = child.key!;
      print("try3");
      final userId = AuthService.user.uid;
      print("try4");
      final imageUrl = await StoreService.uploadFile(file);
      print("try5");
      List<String> images = [];
      for (var i = 0; i < gridImages.length; i++) {
        final image = await StoreService.uploadFile(gridImages[i]!);
        images.add(image);
      }
      print("for");
      final post = Post(
          gridImages: images,
          carPark: carPark,
          swimming: swimming,
          gym: gym,
          restaurant: restaurant,
          wifi: wifi,
          petCenter: petCenter,
          medicalCentre: medicalCentre,
          school: school,
          id: id,
          title: title,
          content: content,
          userId: userId,
          imageUrl: imageUrl,
          isPublic: isPublic,
          createdAt: DateTime.now(),
          comments: [],
          area: area,
          bathrooms: bathrooms,
          email: AuthService.user.email!,
          isApartment: isApartment,
          phone: phone,
          price: price,
          rooms: rooms);
      await child.set(post.toJson());
      print("created");
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  static Future<List<Post>> readAllPost() async {
    final folder = db.ref(Folder.post);
    final data = await folder.get();
    final json = jsonDecode(jsonEncode(data.value)) as Map;
    return json.values
        .map((e) => Post.fromJson(e as Map<String, Object?>))
        .toList();
  }

  static Future<bool> deletePost(String postId) async {
    try {
      final fbPost = db.ref(Folder.post).child(postId);
      await fbPost.remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatePost(
      {required String postId,
      required String title,
      required String content,
      required bool isPublic,
      required File file,
      required bool carPark,
      required bool swimming,
      required bool gym,
      required bool restaurant,
      required bool wifi,
      required bool petCenter,
      required bool medicalCentre,
      required bool school,
      required String area,
      required String bathrooms,
      required bool isApartment,
      required String phone,
      required String price,
      required String rooms,
      required List<File?> gridImages}) async {
    try {
      final fbPost = db.ref(Folder.post).child(postId);
      await fbPost.update({
        "title": title,
        "content": content,
        "isPublic": isPublic,
        "file": file,
        "carPark": carPark,
        "swimming": swimming,
        "gym": gym,
        "restaurant": restaurant,
        "wifi": wifi,
        "petCenter": petCenter,
        "medicalCentre": medicalCentre,
        "school": school,
        "area": area,
        "bathrooms": bathrooms,
        "isApartment": isApartment,
        "phone": phone,
        "price": price,
        "rooms": rooms,
        "gridImages": gridImages,
      });

      // fbPost.set(post.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  static Future<List<Post>> searchPost(String text,
      [SearchType type = SearchType.all]) async {
    try {
      final folder = db.ref(Folder.post);
      final event = await folder
          .orderByChild("title")
          .startAt(text)
          .endAt("$text\uf8ff")
          .once();
      final json = jsonDecode(jsonEncode(event.snapshot.value)) as Map;
      debugPrint("JSON: $json");
      final data = json.values
          .map((e) => Post.fromJson(e as Map<String, Object?>))
          .toList();

      switch (type) {
        case SearchType.all:
          return data.where((element) => element.isPublic == true).toList();
        case SearchType.me:
          return data
              .where((element) => element.userId == AuthService.user.uid)
              .toList();
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      return [];
    }
  }

  static Future<List<Post>> myPost() async {
    try {
      final folder = db.ref(Folder.post);
      final event = await folder
          .orderByChild("userId")
          .equalTo(AuthService.user.uid)
          .once();
      final json = jsonDecode(jsonEncode(event.snapshot.value)) as Map;
      debugPrint("JSON: $json");
      return json.values
          .map((e) => Post.fromJson(e as Map<String, Object?>, isMe: true))
          .toList();
    } catch (e) {
      debugPrint("ERROR: $e");
      return [];
    }
  }

  /// user
  static Future<bool> storeUser(
      String email, String password, String username, String uid) async {
    try {
      final folder = db.ref(Folder.user).child(uid);
      final member = Member(
          uid: uid, username: username, email: email, password: password);
      await folder.set(member.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  static Future<Member?> readUser(String uid) async {
    try {
      final data = db.ref(Folder.user).child(uid).get();
      final member =
          Member.fromJson(jsonDecode(jsonEncode(data)) as Map<String, Object>);
      return member;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return null;
    }
  }

  /// Message
  static Future<bool> writeMessage(
      String postId, String message, List<Message> old) async {
    try {
      final post = db.ref(Folder.post).child(postId);

      final msg = Message(
          id: "${old.length + 1}",
          message: message,
          writtenAt: DateTime.now(),
          userId: AuthService.user.uid,
          userImage: AuthService.user.photoURL,
          username: AuthService.user.displayName!);
      old.add(msg);

      post.update({
        "comments": old.map((e) => e.toJson()).toList(),
      });
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }
}

sealed class Folder {
  static const post = "Post";
  static const user = "User";
  static const postImages = "PostImage";
}

enum SearchType {
  all,
  me,
}
