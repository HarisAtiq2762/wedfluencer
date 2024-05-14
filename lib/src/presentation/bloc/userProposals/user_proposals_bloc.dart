import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_repository.dart';
import 'package:wedfluencer/src/models/proposal_video_api_response.dart';

part 'user_proposals_event.dart';
part 'user_proposals_state.dart';

class UserProposalsBloc extends Bloc<UserProposalsEvent, UserProposalsState> {
  final repository = UserRepository();

  UserProposalsBloc() : super(UserProposalsInitial()) {
    on<GetUserProposals>((event, emit) async {
      emit(UserProposalsLoading());
      try {
        final result = await repository.getProposalVideos(
            accessToke: event.accessToken, isMe: event.isMe);
        emit(GotUserProposals(proposalVideoApiResponse: result));
      } catch (e) {
        emit(UserProposalsError(error: e.toString()));
        emit(UserProposalsInitial());
      }
    });
  }
}
