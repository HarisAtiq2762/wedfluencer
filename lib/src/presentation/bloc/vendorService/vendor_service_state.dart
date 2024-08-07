part of 'vendor_service_bloc.dart';

abstract class VendorServiceState {}

class GotVendorService extends VendorServiceState {
  final List<VendorServiceOrCategory> vendorServices;
  GotVendorService({required this.vendorServices});
}

class VendorServiceInitial extends VendorServiceState {}

class VendorServiceLoading extends VendorServiceState {}

class VendorServiceError extends VendorServiceState {
  final String error;
  VendorServiceError({required this.error});
}
