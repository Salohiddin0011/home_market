part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class CreatePostEvent extends PostEvent {
  final String title;
  final String content;
  final List<Facilities> facilities;
  final String area;
  final String bathrooms;
  final bool isApartment;
  final String phone;
  final String price;
  final String rooms;
  final List<File?> gridImages;

  const CreatePostEvent({
    required this.title,
    required this.content,
    required this.facilities,
    required this.area,
    required this.bathrooms,
    required this.isApartment,
    required this.phone,
    required this.price,
    required this.rooms,
    required this.gridImages,
  });

  @override
  List<Object?> get props => [
        title,
        content,
        area,
        bathrooms,
        isApartment,
        phone,
        price,
        rooms,
        gridImages,
        facilities,
      ];
}

class PostIsApartmentEvent extends PostEvent {
  final bool isApartment;
  const PostIsApartmentEvent(this.isApartment);

  @override
  List<Object?> get props => [isApartment];
}

class DeletePostEvent extends PostEvent {
  final String postId;
  final List<String> postImages;
  const DeletePostEvent(this.postId, this.postImages);

  @override
  List<Object?> get props => [postId, postImages];
}

class UpdatePostEvent extends PostEvent {
  final String postId;
  final String title;
  final String content;
  final List<Facilities> facilities;
  final String area;
  final String bathrooms;
  final bool isApartment;
  final String phone;
  final String price;
  final String rooms;
  final List<File?> gridImages;
  final List<String>? imagesUri;
  final List<String> isLiked;

  const UpdatePostEvent(
      {required this.title,
      required this.isLiked,
      required this.content,
      required this.facilities,
      required this.area,
      required this.bathrooms,
      required this.isApartment,
      required this.phone,
      required this.price,
      required this.rooms,
      required this.postId,
      required this.gridImages,
      required this.imagesUri});

  @override
  List<Object?> get props => [
        title,
        content,
        area,
        bathrooms,
        isApartment,
        phone,
        price,
        rooms,
        postId,
        gridImages,
        facilities,
        imagesUri,
        isLiked,
      ];
}

class UpdateLikePostEvent extends PostEvent {
  final String postId;
  final String title;
  final String content;
  final List<Facilities> facilities;
  final String area;
  final String bathrooms;
  final bool isApartment;
  final List<String> isLiked;

  final String phone;
  final String price;
  final String rooms;
  final List<String> gridImages;

  const UpdateLikePostEvent({
    required this.title,
    required this.content,
    required this.facilities,
    required this.area,
    required this.bathrooms,
    required this.isApartment,
    required this.isLiked,
    required this.phone,
    required this.price,
    required this.rooms,
    required this.postId,
    required this.gridImages,
  });

  @override
  List<Object?> get props => [
        title,
        content,
        area,
        bathrooms,
        isApartment,
        isLiked,
        phone,
        price,
        rooms,
        postId,
        gridImages,
        facilities,
      ];
}

class ViewGridImagesPostEvent extends PostEvent {
  final List<File?> files;
  const ViewGridImagesPostEvent(this.files);

  @override
  List<Object?> get props => [files];
}

class FacilitiesPostEvent extends PostEvent {
  final List<Facilities> facilities;
  final Facilities facility;
  const FacilitiesPostEvent({required this.facilities, required this.facility});

  @override
  List<Object?> get props => [facilities, facility];
}

class WriteCommentPostEvent extends PostEvent {
  final String postId;
  final String message;
  final List<Message> old;
  const WriteCommentPostEvent(this.postId, this.message, this.old);

  @override
  List<Object?> get props => [postId, message, old];
}
