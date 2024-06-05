import 'package:wedfluencer/src/infrastructure/resources/payment/payment_provider.dart';

class PaymentRepository {
  final paymentProvider = PaymentProvider();
  Future<String> createSessionOnStripe({
    required String videoId,
  }) =>
      paymentProvider.createSessionOnStripe(videoId: videoId);
}
