import 'package:home_market/models/facilities_model.dart';
import 'package:home_market/models/message_model.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String userId;
  List<String> gridImages;
  final String phone;
  final String email;
  final String price;

  final String area;
  final String rooms;
  final String bathrooms;
  final bool isApartment;
  //! Facilities
  List<Facilities> facilities;
  final bool isMe;
  List<Message> comments;
  final DateTime createdAt;

  Post(
      {this.isMe = false,
      required this.facilities,
      required this.id,
      required this.title,
      required this.content,
      required this.userId,
      required this.createdAt,
      required this.comments,
      required this.area,
      required this.bathrooms,
      required this.email,
      required this.isApartment,
      required this.phone,
      required this.price,
      required this.rooms,
      required this.gridImages});

  factory Post.fromJson(Map<String, Object?> json, {bool isMe = false}) {
    return Post(
      gridImages: (json['gridImages'] as List).map((e) => e as String).toList(),
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
      comments: json["comments"] != null
          ? (json["comments"] as List)
              .map((item) => Message.fromJson(item as Map<String, Object?>))
              .toList()
          : [],
      area: json['area'] as String,
      bathrooms: json['bathrooms'] as String,
      email: json['email'] as String,
      isApartment: json['isApartment'] as bool,
      phone: json['phone'] as String,
      price: json['price'] as String,
      rooms: json['rooms'] as String,
      facilities: (json['facilities'] != null)
          ? (json['facilities'] as List)
              .map((e) => Facilities.fromJson(e as Map<String, Object?>))
              .toList()
          : [],
    );
  }

  Map<String, Object?> toJson() => {
        "gridImages": gridImages,
        "id": id,
        "title": title,
        "content": content,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "comments": comments.map((e) => e.toJson()).toList(),
        "area": area,
        "bathrooms": bathrooms,
        "email": email,
        "isApartment": isApartment,
        "phone": phone,
        "price": price,
        "rooms": rooms,
        "facilities": facilities.map((e) => e.toJson()).toList(),
      };
}
