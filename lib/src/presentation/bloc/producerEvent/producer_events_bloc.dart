import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_repository.dart';

import '../../../models/producer_event.dart';

part 'producer_events_event.dart';
part 'producer_events_state.dart';

class ProducerEventsBloc
    extends Bloc<ProducerEventsEvent, ProducerEventsState> {
  final repository = UserRepository();

  ProducerEventsBloc() : super(ProducerEventsInitial()) {
    on<GetProducerEvents>((event, emit) async {
      if (int.parse(event.take) <= 10) {
        emit(ProducerEventsLoading());
      }

      try {
        final result = await repository.getProducerEvents(
            take: event.take, search: event.search);
        emit(GotProducerEvents(events: result));
      } catch (e) {
        emit(ProducerEventsError(error: e.toString()));
        emit(ProducerEventsInitial());
      }
    });
  }
}
