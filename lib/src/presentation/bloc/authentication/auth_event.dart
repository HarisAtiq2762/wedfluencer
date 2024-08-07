import 'package:equatable/equatable.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_dto.dart';

class AuthenticationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationSignInEvent extends AuthenticationEvent {
  final UserDTO dto;
  AuthenticationSignInEvent({required this.dto});
}

class AuthenticationSignOutEvent extends AuthenticationEvent {}
