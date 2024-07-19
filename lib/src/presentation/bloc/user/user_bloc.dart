import 'package:bloc/bloc.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_model.dart';
import 'package:wedfluencer/src/infrastructure/resources/authentication/authentication_repository.dart';
import 'package:wedfluencer/src/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    AuthenticationRepository repository = AuthenticationRepository();

    on<LoginUser>((event, emit) async {
      emit(Loading());

      try {
        final wedfluencerUser = await repository.loginUser(
          email: event.email,
          password: event.password,
        );
        emit(UserLoggedIn(user: wedfluencerUser));
      } catch (e) {
        emit(GotError(error: e.toString()));
        emit(UserInitial());
      }
    });

    on<GetEmailPassword>((event, emit) async {
      emit(Loading());

      try {
        final result = await repository.registerEmailAndGetOtp(
            email: event.email,
            password: event.password,
            confirmPassword: event.password);
        if (result) {
          emit(GotEmailPassword(
            user: User(
              role: UserRole.loggedOut,
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
      } catch (e) {
        emit(GotError(error: e.toString()));
        emit(UserInitial());
      }
    });

    on<VerifyOtp>((event, emit) async {
      emit(Loading());
      final result = await repository.verifyOtp(
        otp: event.otp,
        user: event.user,
      );
      print(result);
      if (result.sucess) {
        emit(OtpVerified(user: event.user, otp: event.otp));
      } else {
        emit(GotError(error: result.message));
        emit(GotEmailPassword(user: event.user));
      }
    });

    on<GetUserChoiceForWeddingBusiness>((event, emit) {
      emit(GotUserChoiceForWeddingBusiness(
        user: User(
          role: event.user.role,
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
          role: event.user.role,
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
          role: event.user.role,
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

    on<GetUserWeddingDetails>((event, emit) {
      emit(GotUserWeddingDetails(
        user: event.user,
        weddingDate: event.weddingDate,
        weddingType: event.weddingType,
        guestCount: event.guestCount,
        weddingLocation: event.weddingLocation,
      ));
    });

    on<GetUserPhoneOtp>((event, emit) async {
      emit(Loading());
      final result = await repository.sendPhoneOtp(
        weddingDate: event.weddingDate,
        city: event.city,
        countyCode: event.countryCode,
        phone: event.phone,
        weddingType: event.weddingType,
        phoneNumber: event.phoneNumber,
        guests: event.guests,
        user: event.user,
      );
      print(result);
      if (result['status']) {
        emit(PhoneOtpSent(
            weddingDate: event.weddingDate,
            weddingType: event.weddingType,
            guests: event.guests,
            phoneNumber: event.phoneNumber,
            user: event.user,
            city: event.city,
            countryCode: event.countryCode,
            phone: event.phone));
      } else {
        emit(GotError(error: result['message']));
        emit(GotUserProfileDetails(user: event.user));
      }
    });

    on<VerifyPhoneOtpAndRegister>((event, emit) async {
      emit(Loading());
      final wedfluencerUser = await repository.verifyPhoneOtpAndRegister(
        weddingDate: event.weddingDate,
        city: event.city,
        countyCode: event.countryCode,
        phone: event.phone,
        weddingType: event.weddingType,
        phoneNumber: event.phoneNumber,
        user: event.user,
        otp: event.otp,
        guests: event.guests,
      );
      print(wedfluencerUser.toJson());
      emit(UserLoggedIn(user: wedfluencerUser));
    });
  }
}
