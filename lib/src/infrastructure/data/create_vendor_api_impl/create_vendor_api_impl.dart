import 'package:wedfluencer/src/infrastructure/data/create_vendor_api_impl/end_point.dart';
import 'package:wedfluencer/src/infrastructure/domain/create_vendor/vendor_dto.dart';
import 'package:wedfluencer/src/infrastructure/network_service_layer/api_handler.dart';
import 'package:wedfluencer/src/infrastructure/resources/vendor/vendor_provider.dart';

class VendorApiImpl {
  final APIService _apiServices = APIService(baseUrl: serverUrl);
  final endPoint = VendorEndPoint();

  Future<bool> createVendor(VendorDTO dto, String otp) async {
    final response = await _apiServices.apiCall(
        urlExt: endPoint.createVendor,
        type: RequestType.post,
        body: dto.toJson(otp));
    return response.sucess;
  }

  Future<bool> phoneOtp(VendorDTO dto) async {
    final response = await _apiServices.apiCall(
        urlExt: endPoint.phoneOtp,
        type: RequestType.post,
        body: dto.toPhoneJson());
    return response.sucess;
  }
}
