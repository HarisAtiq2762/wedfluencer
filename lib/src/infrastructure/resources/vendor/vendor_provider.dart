import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../models/vendor_service_or_category.dart';
import '../../../presentation/ui/config/globals.dart';

String serverUrl = serverUrlGlobal;

class VendorProvider {
  Future<List<VendorServiceOrCategory>> getVendorServicesOrCategories(
      {required bool isService}) async {
    try {
      Uri url = Uri();
      if (isService) {
        url = Uri.parse(
            '${serverUrl}category?types=VendorService&take=1000&page=1');
      } else {
        url = Uri.parse('${serverUrl}category?types=Vendor&take=1000&page=1');
      }

      print(url);

      final response = await http.get(
        url,
        headers: {
          // 'Authorization': 'Bearer $userTokenGlobal',
          'Content-Type': 'application/json'
        },
      );
      print(response.statusCode);
      print(response.body);
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      print(responseBody['status']);
      print(responseBody['data']['data']);
      if (responseBody['status']) {
        final List<VendorServiceOrCategory> vendorServices = [];
        responseBody['data']['data'].forEach((service) {
          final vendorService = VendorServiceOrCategory.fromJson(service);
          vendorServices.add(vendorService);
        });
        return vendorServices;
      }
      // error500 = responseBody['message'];
      // if (response.statusCode >= 500 && response.statusCode <= 599) {
      //   // throw error500;
      // } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      //   // throw error500;
      //   // return false;
      // } else {
      return responseBody;
      // }
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
