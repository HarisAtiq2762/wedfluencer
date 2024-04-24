import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_repository.dart';

import '../../../models/video.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final repository = UserRepository();

  UserHomeBloc() : super(UserHomeInitial()) {
    on<GetExploreVideos>((event, emit) async {
      emit(UserHomeLoading());
      try {
        final result = await repository.getExploreVideos();
        emit(GotExploreVideos(videos: result));
      } catch (e) {
        emit(UserHomeError(error: e.toString()));
        emit(UserHomeInitial());
      }
    });
  }
}
