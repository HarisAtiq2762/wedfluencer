import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/data/create_vendor_api_impl/create_vendor_api_impl.dart';
import 'package:wedfluencer/src/infrastructure/domain/create_vendor/vendor_dto.dart';
import 'package:wedfluencer/src/presentation/ui/config/helper.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/login_screen.dart';
import 'package:wedfluencer/src/presentation/ui/templates/snackbar.dart';

class VendorCreationRepository {
  VendorApiImpl vendorApi = VendorApiImpl();
  Future<bool> phoneOTP(VendorDTO dto, BuildContext context) async {
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

  // Future<bool> createVendor(
  //     VendorDTO dto, String otp, BuildContext context) async {
  //   try {
  //     final response = await vendorApi.createVendor(dto, otp);
  //     if (response) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(WedfluencerSnackBar.showSnackBar('Vendor created'));
  //       WedfluencerHelper.createRoute(page: const LoginScreen());
  //       return response;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         WedfluencerSnackBar.showSnackBar('Something went wrong'));
  //     return false;
  //   }
  // }

  Future<bool> registerVendor(
      VendorDTO dto, String otp, BuildContext context) async {
    try {
      final response = await vendorApi.registerVendor(dto, otp);
      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(
            WedfluencerSnackBar.showSnackBar("${dto.userType} Created"));
        WedfluencerHelper.createRoute(page: const LoginScreen());
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
