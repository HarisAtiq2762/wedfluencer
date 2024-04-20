part of 'vendor_category_bloc.dart';

abstract class VendorCategoryState {}

class GotVendorCategory extends VendorCategoryState {
  final List<VendorServiceOrCategory> vendorCategory;
  GotVendorCategory({required this.vendorCategory});
}

class VendorCategoryInitial extends VendorCategoryState {}

class VendorCategoryLoading extends VendorCategoryState {}

class VendorCategoryError extends VendorCategoryState {
  final String error;
  VendorCategoryError({required this.error});
}
