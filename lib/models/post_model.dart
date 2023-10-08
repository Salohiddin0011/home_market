import 'package:home_market/models/message_model.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String userId;
  final String imageUrl;
  final bool isPublic;
  final String phone;
  final String email;
  final String price;

  final String area;
  final String rooms;
  final String bathrooms;
  final bool isApartment;
  //! Facilities
  bool carPark;
  bool swimming;
  bool gym;
  bool restaurant;
  bool wifi;
  bool petCenter;
  bool medicalCentre;
  bool school;
  final bool isMe;
  List<Message> comments;
  final DateTime createdAt;
  // final List<String> images;

  Post(
      {this.isMe = false,
      this.carPark = false,
      this.swimming = false,
      this.gym = false,
      this.restaurant = false,
      this.wifi = false,
      this.petCenter = false,
      this.medicalCentre = false,
      this.school = false,
      required this.id,
      required this.title,
      required this.content,
      required this.userId,
      required this.imageUrl,
      required this.isPublic,
      required this.createdAt,
      required this.comments,
      required this.area,
      required this.bathrooms,
      required this.email,
      required this.isApartment,
      required this.phone,
      required this.price,
      required this.rooms});

  factory Post.fromJson(Map<String, Object?> json, {bool isMe = false}) {
    return Post(
      id: json["id"] as String,
      title: json["title"] as String,
      content: json["content"] as String,
      userId: json["userId"] as String,
      imageUrl: json["imageUrl"] as String,
      isPublic: json["isPublic"] as bool,
      createdAt: DateTime.parse(json["createdAt"] as String),
      isMe: isMe,
      comments: json["comments"] != null
          ? (json["comments"] as List)
              .map((item) => Message.fromJson(item as Map<String, Object?>))
              .toList()
          : [],
    );
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "userId": userId,
        "imageUrl": imageUrl,
        "isPublic": isPublic,
        "comments": comments.map((e) => e.toJson()).toList(),
        "createdAt": createdAt.toIso8601String()
      };
}
