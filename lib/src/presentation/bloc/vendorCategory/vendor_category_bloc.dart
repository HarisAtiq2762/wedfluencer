import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/resources/vendor/vendor_repository.dart';
import '../../../models/vendor_service_or_category.dart';

part 'vendor_category_event.dart';
part 'vendor_category_state.dart';

class VendorCategoryBloc
    extends Bloc<VendorCategoryEvent, VendorCategoryState> {
  final repository = VendorRepository();

  VendorCategoryBloc() : super(VendorCategoryInitial()) {
    on<GetVendorCategory>((event, emit) async {
      emit(VendorCategoryLoading());
      try {
        final result =
            await repository.getVendorServicesOrCategories(isService: false);
        emit(GotVendorCategory(vendorCategory: result));
      } catch (e) {
        emit(VendorCategoryError(error: e.toString()));
        emit(VendorCategoryInitial());
      }
    });
  }
}
