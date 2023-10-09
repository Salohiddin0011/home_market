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
  final bool carPark;
  final bool swimming;
  final bool gym;
  final bool restaurant;
  final bool wifi;
  final bool petCenter;
  final bool medicalCentre;
  final bool school;
  final bool isMe;
  List<Message> comments;
  final DateTime createdAt;
  // final List<String> images;

  Post(
      {this.isMe = false,
      required this.carPark,
      required this.swimming,
      required this.gym,
      required this.restaurant,
      required this.wifi,
      required this.petCenter,
      required this.medicalCentre,
      required this.school,
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
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      imageUrl: json['imageUrl'] as String,
      isPublic: json['isPublic'] as bool,
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
      carPark: json['carPark'] as bool,
      swimming: json['swimming'] as bool,
      gym: json['gym'] as bool,
      restaurant: json['restaurant'] as bool,
      wifi: json['wifi'] as bool,
      petCenter: json['petCenter'] as bool,
      medicalCentre: json['medicalCentre'] as bool,
      school: json['school'] as bool,
    );
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "userId": userId,
        "imageUrl": imageUrl,
        "isPublic": isPublic,
        "createdAt": createdAt.toIso8601String(),
        "comments": comments.map((e) => e.toJson()).toList(),
        "area": area,
        "bathrooms": bathrooms,
        "email": email,
        "isApartment": isApartment,
        "phone": phone,
        "price": price,
        "rooms": rooms,
        "carPark": carPark,
        "swimming": swimming,
        "gym": gym,
        "restaurant": restaurant,
        "wifi": wifi,
        "petCenter": petCenter,
        "medicalCentre": medicalCentre,
        "school": school,
      };
}
