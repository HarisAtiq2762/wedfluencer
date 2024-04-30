import 'package:flutter/material.dart';
import 'package:wedfluencer/src/data/create_vendor_api_impl/create_vendor_api_impl.dart';
import 'package:wedfluencer/src/domain/create_vendor/vendor_dto.dart';
import 'package:wedfluencer/src/presentation/ui/templates/snackbar.dart';

class VendorCreationRepository {
  VendorApiImpl vendorApi = VendorApiImpl();
  Future<bool> createVendor(VendorDTO dto, BuildContext context) async {
    try {
      final response = await vendorApi.phoneOtp(dto);
      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(
            WedfluencerSnackBar.showSnackBar('OTP Sent Sucessfull'));
        //Next navagation
      }
      return response;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          WedfluencerSnackBar.showSnackBar('Something went wrong'));
      return false;
    }
  }

  Future<bool> requestPhoneOTP(VendorDTO dto, BuildContext context) async {
    try {
      final response = await vendorApi.phoneOtp(dto);
      if (response) {
        ScaffoldMessenger.of(context)
            .showSnackBar(WedfluencerSnackBar.showSnackBar('OTP sent'));
        return response;
      } else {
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          WedfluencerSnackBar.showSnackBar('Something went wrong'));
      return false;
    }
  }
}
