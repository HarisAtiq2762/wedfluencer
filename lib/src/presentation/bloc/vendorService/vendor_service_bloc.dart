import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/resources/vendor/vendor_repository.dart';
import '../../../models/vendor_service_or_category.dart';

part 'vendor_service_event.dart';
part 'vendor_service_state.dart';

class VendorServiceBloc extends Bloc<VendorServiceEvent, VendorServiceState> {
  final repository = VendorRepository();

  VendorServiceBloc() : super(VendorServiceInitial()) {
    on<GetVendorService>((event, emit) async {
      emit(VendorServiceLoading());
      try {
        final result =
            await repository.getVendorServicesOrCategories(isService: true);
        emit(GotVendorService(vendorServices: result));
      } catch (e) {
        emit(VendorServiceError(error: e.toString()));
        emit(VendorServiceInitial());
      }
    });
  }
}
