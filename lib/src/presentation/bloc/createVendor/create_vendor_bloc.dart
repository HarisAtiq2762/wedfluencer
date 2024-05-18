import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/domain/create_vendor/vendor_repository.dart';
import 'package:wedfluencer/src/presentation/bloc/createVendor/create_vendor_event.dart';
import 'package:wedfluencer/src/presentation/bloc/createVendor/create_vendor_state.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/login_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/otp_screen.dart';

class CreateVendorBloc extends Bloc<CreateVendorEvent, CreateVendorState> {
  CreateVendorBloc() : super(CreateVendorState.initial()) {
    on<VendorCreationEvent>(_onVendorCreation);
    on<VendorRegistrationEvent>(_onVendorRegistration);
  }

  final vendorRepo = VendorCreationRepository();

  void _onVendorCreation(
      VendorCreationEvent event, Emitter<CreateVendorState> emit) async {
    emit(state.copyWith(
      vendorRegistrationLoading: true,
    ));

    final response = await vendorRepo.phoneOTP(event.dto, event.context);
    if (response) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    isPhoneVerification: true,
                    vendorDto: event.dto,
                  )));
    }

    emit(state.copyWith(
      vendorRegistrationLoading: false,
    ));
  }

  void _onVendorRegistration(
      VendorRegistrationEvent event, Emitter<CreateVendorState> emit) async {
    emit(state.copyWith(
      vendorRegistrationLoading: true,
    ));

    final response =
        await vendorRepo.registerVendor(event.dto, event.otp, event.context);
    if (response) {
      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    emit(state.copyWith(
      vendorRegistrationLoading: false,
    ));
  }
}
