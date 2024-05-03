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
          'take': '1000',
          'page': '1',
        },
        type: RequestType.get,
      );
      if (response.sucess) {
        final List<VendorServiceOrCategory> vendorServices = [];
        response.data['data'].forEach((service) {
          final vendorService = VendorServiceOrCategory.fromJson(service);
          vendorServices.add(vendorService);
        });
        return vendorServices;
      }
      return response.data;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
