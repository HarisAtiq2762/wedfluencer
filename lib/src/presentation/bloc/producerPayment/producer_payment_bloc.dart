import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_repository.dart';

import '../../../models/producer_payment.dart';

part 'producer_payment_event.dart';
part 'producer_payment_state.dart';

class ProducerPaymentsBloc
    extends Bloc<ProducerPaymentsEvent, ProducerPaymentsState> {
  final repository = UserRepository();

  ProducerPaymentsBloc() : super(ProducerPaymentsInitial()) {
    on<GetProducerPayments>((event, emit) async {
      if (event.take <= 10) {
        emit(ProducerPaymentsLoading());
      }
      try {
        final result = await repository.getPayments(
            search: event.search, page: event.page, take: event.take);
        emit(GotProducerPayments(payments: result));
      } catch (e) {
        emit(ProducerPaymentsError(error: e.toString()));
        emit(ProducerPaymentsInitial());
      }
    });
  }
}
