part of 'user_home_bloc.dart';

abstract class UserHomeState {}

class GotExploreVideos extends UserHomeState {
  final List<VideoData> videos;
  GotExploreVideos({required this.videos});
}

class UserHomeInitial extends UserHomeState {}

class UserHomeLoading extends UserHomeState {}

class UserHomeError extends UserHomeState {
  final String error;
  UserHomeError({required this.error});
}
