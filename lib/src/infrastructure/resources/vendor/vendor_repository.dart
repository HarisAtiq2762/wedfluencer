import 'package:wedfluencer/src/infrastructure/resources/vendor/vendor_provider.dart';

import '../../../models/vendor_service_or_category.dart';

class VendorRepository {
  final vendorProvider = VendorProvider();
  Future<List<VendorServiceOrCategory>> getVendorServicesOrCategories(
          {required bool isService}) =>
      vendorProvider.getVendorServicesOrCategories(isService: isService);
}
