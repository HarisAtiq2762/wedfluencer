import 'package:bloc/bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/authentication/authentication_repository.dart';
import 'package:wedfluencer/src/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    AuthenticationRepository repository = AuthenticationRepository();
    on<GetEmailPassword>((event, emit) async {
      emit(Loading());
      final result = await repository.registerEmailAndGetOtp(
          email: event.email,
          password: event.password,
          confirmPassword: event.password);
      if (result['success']) {
        emit(GotEmailPassword(
          user: User(
            email: event.email,
            password: event.password,
            isInWeddingBusiness: false,
            isGettingMarried: false,
            firstName: '',
            lastName: '',
            userName: '',
            phoneNumber: '',
          ),
        ));
      } else {
        emit(GotError(error: 'Something went wrong'));
        emit(UserInitial());
      }
    });
    on<GetUserChoiceForWeddingBusiness>((event, emit) {
      emit(GotUserChoiceForWeddingBusiness(
        user: User(
          email: event.user.email,
          password: event.user.password,
          isInWeddingBusiness: event.isInWeddingBusiness,
          isGettingMarried: false,
          firstName: '',
          lastName: '',
          userName: '',
          phoneNumber: '',
        ),
      ));
    });
    on<GetUserChoiceForGettingMarried>((event, emit) {
      emit(GotUserChoiceForGettingMarried(
        user: User(
          email: event.user.email,
          password: event.user.password,
          isInWeddingBusiness: event.user.isInWeddingBusiness,
          isGettingMarried: event.isGettingMarried,
          firstName: '',
          lastName: '',
          userName: '',
          phoneNumber: '',
        ),
      ));
    });

    on<GetUserProfileDetails>((event, emit) {
      emit(GotUserProfileDetails(
        user: User(
          email: event.user.email,
          password: event.user.password,
          isInWeddingBusiness: event.user.isInWeddingBusiness,
          isGettingMarried: event.user.isGettingMarried,
          firstName: event.firstName,
          lastName: event.lastName,
          userName: event.userName,
          phoneNumber: event.phoneNumber,
        ),
      ));
    });
  }
}
