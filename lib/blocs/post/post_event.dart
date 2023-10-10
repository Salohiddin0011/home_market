part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class CreatePostEvent extends PostEvent {
  final String title;
  final String content;
  final bool isPublic;
  final File file;
  final bool carPark;
  final bool swimming;
  final bool gym;
  final bool restaurant;
  final bool wifi;
  final bool petCenter;
  final bool medicalCentre;
  final bool school;
  final String area;
  final String bathrooms;
  final bool isApartment;
  final String phone;
  final String price;
  final String rooms;
  final List<File?> gridImages;

  const CreatePostEvent(
      {required this.title,
      required this.content,
      required this.isPublic,
      required this.file,
      required this.carPark,
      required this.swimming,
      required this.gym,
      required this.restaurant,
      required this.wifi,
      required this.petCenter,
      required this.medicalCentre,
      required this.school,
      required this.area,
      required this.bathrooms,
      required this.isApartment,
      required this.phone,
      required this.price,
      required this.rooms,
      required this.gridImages});

  @override
  List<Object?> get props => [
        title,
        content,
        isPublic,
        file,
        carPark,
        swimming,
        gym,
        restaurant,
        wifi,
        petCenter,
        medicalCentre,
        school,
        area,
        bathrooms,
        isApartment,
        phone,
        price,
        rooms,
        gridImages
      ];
}

class PostIsPublicEvent extends PostEvent {
  final bool isPublic;
  const PostIsPublicEvent(this.isPublic);

  @override
  List<Object?> get props => [isPublic];
}

class DeletePostEvent extends PostEvent {
  final String postId;
  const DeletePostEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

class UpdatePostEvent extends PostEvent {
  final String postId;
  final String title;
  final String content;
  final bool isPublic;
  final File file;
  final bool carPark;
  final bool swimming;
  final bool gym;
  final bool restaurant;
  final bool wifi;
  final bool petCenter;
  final bool medicalCentre;
  final bool school;
  final String area;
  final String bathrooms;
  final bool isApartment;
  final String phone;
  final String price;
  final String rooms;
  final List<File?> gridImages;
  const UpdatePostEvent(
      {required this.title,
      required this.content,
      required this.isPublic,
      required this.file,
      required this.carPark,
      required this.swimming,
      required this.gym,
      required this.restaurant,
      required this.wifi,
      required this.petCenter,
      required this.medicalCentre,
      required this.school,
      required this.area,
      required this.bathrooms,
      required this.isApartment,
      required this.phone,
      required this.price,
      required this.rooms,
      required this.postId,
      required this.gridImages});

  @override
  List<Object?> get props => [
        title,
        content,
        isPublic,
        file,
        carPark,
        swimming,
        gym,
        restaurant,
        wifi,
        petCenter,
        medicalCentre,
        school,
        area,
        bathrooms,
        isApartment,
        phone,
        price,
        rooms,
        postId,
        gridImages
      ];
}

class ViewImagePostEvent extends PostEvent {
  final File file;
  const ViewImagePostEvent(this.file);

  @override
  List<Object?> get props => [file];
}

class ViewGridImagesPostEvent extends PostEvent {
  final List<File?> files;
  const ViewGridImagesPostEvent(this.files);

  @override
  List<Object?> get props => [files];
}

class WriteCommentPostEvent extends PostEvent {
  final String postId;
  final String message;
  final List<Message> old;
  const WriteCommentPostEvent(this.postId, this.message, this.old);

  @override
  List<Object?> get props => [postId, message, old];
}
