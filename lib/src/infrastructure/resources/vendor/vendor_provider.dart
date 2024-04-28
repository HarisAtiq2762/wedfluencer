import 'dart:async';
import 'dart:io';
import '../../../models/vendor_service_or_category.dart';
import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class VendorProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);
  Future<List<VendorServiceOrCategory>> getVendorServicesOrCategories(
      {required bool isService}) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'category',
        queryParameters: {
          'types': isService ? 'VendorService' : 'Vendor',
          'take': 1000,
          'page': 1,
        },
        type: RequestType.get,
      );
      // Uri url = Uri();
      // if (isService) {
      //   url = Uri.parse(
      //       '${serverUrl}category?types=VendorService&take=1000&page=1');
      // } else {
      //   url = Uri.parse('${serverUrl}category?types=Vendor&take=1000&page=1');
      // }

      // print(url);

      // final response = await http.get(
      //   url,
      //   headers: {
      //     // 'Authorization': 'Bearer $userTokenGlobal',
      //     'Content-Type': 'application/json'
      //   },
      // );
      // print(response.statusCode);
      // print(response.body);
      // final responseBody = jsonDecode(response.body);
      // print(responseBody);
      // print(responseBody['status']);
      // print(responseBody['data']['data']);
      if (response.sucess) {
        final List<VendorServiceOrCategory> vendorServices = [];
        response.data['data'].forEach((service) {
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
      return response.data;
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
