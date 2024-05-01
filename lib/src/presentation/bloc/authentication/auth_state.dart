import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  final bool signInLoading;

  const AuthenticationState({required this.signInLoading});

  factory AuthenticationState.initial() {
    return const AuthenticationState(signInLoading: false);
  }

  AuthenticationState copyWith({bool? signInLoading}) {
    return AuthenticationState(
      signInLoading: signInLoading ?? this.signInLoading,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [signInLoading];
}
