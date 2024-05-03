import 'package:equatable/equatable.dart';

class CreateVendorState extends Equatable {
  final bool vendorRegistrationLoading;

  const CreateVendorState({required this.vendorRegistrationLoading});

  factory CreateVendorState.initial() {
    return const CreateVendorState(
      vendorRegistrationLoading: false,
    );
  }

  CreateVendorState copyWith({
    bool? vendorRegistrationLoading,
  }) {
    return CreateVendorState(
        vendorRegistrationLoading:
            vendorRegistrationLoading ?? this.vendorRegistrationLoading);
  }

  @override
  List<Object?> get props => [vendorRegistrationLoading];
}
