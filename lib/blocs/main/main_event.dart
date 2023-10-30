part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class GetAllDataEvent extends MainEvent {
  const GetAllDataEvent();

  @override
  List<Object?> get props => [];
}

class SearchMainEvent extends MainEvent {
  final String searchText;

  const SearchMainEvent(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

class AllPublicPostEvent extends MainEvent {
  const AllPublicPostEvent();

  @override
  List<Object?> get props => [];
}

class MyPostEvent extends MainEvent {
  const MyPostEvent();

  @override
  List<Object?> get props => [];
}

class MyLikedEvent extends MainEvent {
  final Post post;
  final String userId;
  const MyLikedEvent({required this.post, required this.userId});

  @override
  List<Object?> get props => [post, userId];
}

class ActivateRCEvent extends MainEvent {
  const ActivateRCEvent();

  @override
  List<Object?> get props => [];
}
