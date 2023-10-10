import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_market/models/message_model.dart';
import 'package:home_market/services/firebase/db_service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<CreatePostEvent>(_createPost);
    on<PostIsPublicEvent>(_changePublic);
    on<DeletePostEvent>(_deletePost);
    on<UpdatePostEvent>(_updatePost);
    on<ViewImagePostEvent>(_viewImage);
    on<WriteCommentPostEvent>(_writeComment);
  }

  void _createPost(CreatePostEvent event, Emitter emit) async {
    emit(PostLoading());
    final result = await DBService.storePost(
        title: event.title,
        content: event.content,
        isPublic: event.isPublic,
        file: event.file,
        carPark: event.carPark,
        swimming: event.swimming,
        gym: event.gym,
        restaurant: event.restaurant,
        wifi: event.wifi,
        petCenter: event.petCenter,
        medicalCentre: event.medicalCentre,
        school: event.school,
        area: event.area,
        bathrooms: event.bathrooms,
        isApartment: event.isApartment,
        phone: event.phone,
        price: event.price,
        rooms: event.rooms);
    if (result) {
      emit(CreatePostSuccess());
    } else {
      emit(const PostFailure("Something error, tyr again later!!!"));
    }
  }

  void _changePublic(PostIsPublicEvent event, Emitter emit) {
    emit(PostIsPublicState(event.isPublic));
  }

  void _viewImage(ViewImagePostEvent event, Emitter emit) {
    emit(ViewImagePostSuccess(event.file));
  }

  void _deletePost(DeletePostEvent event, Emitter emit) async {
    emit(PostLoading());
    final result = await DBService.deletePost(event.postId);

    if (result) {
      emit(DeletePostSuccess());
    } else {
      emit(const PostFailure("Something error"));
    }
  }

  void _updatePost(UpdatePostEvent event, Emitter emit) async {
    emit(PostLoading());
    final result = await DBService.updatePost(
      postId: event.postId,
      title: event.title,
      content: event.content,
      isPublic: event.isPublic,
      file: event.file,
      carPark: event.carPark,
      swimming: event.swimming,
      gym: event.gym,
      restaurant: event.restaurant,
      wifi: event.wifi,
      petCenter: event.petCenter,
      medicalCentre: event.medicalCentre,
      school: event.school,
      area: event.area,
      bathrooms: event.bathrooms,
      isApartment: event.isApartment,
      phone: event.phone,
      price: event.price,
      rooms: event.rooms,
    );
    if (result) {
      emit(UpdatePostSuccess());
    } else {
      emit(const PostFailure("Something error, tyr again later!!!"));
    }
  }

  void _writeComment(WriteCommentPostEvent event, Emitter emit) async {
    emit(PostLoading());
    final result =
        await DBService.writeMessage(event.postId, event.message, event.old);
    if (result) {
      emit(const WriteCommentPostSuccess());
    } else {
      emit(const PostFailure("Something error, tyr again later!!!"));
    }
  }
}
