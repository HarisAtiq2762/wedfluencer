import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/producerPayment/producer_payment_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/templates/cards.dart';

import '../../templates/khairyat_appbar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int take = 1;
    return Scaffold(
      appBar: WedfluencerAppbar.generalAppbar(
        title: 'Payments',
        context: context,
        showBackButton: true,
      ),
      body: BlocBuilder<ProducerPaymentsBloc, ProducerPaymentsState>(
        builder: (BuildContext context, state) {
          double totalEarnings = 0;
          if (state is GotProducerPayments) {
            for (var payment in state.payments) {
              totalEarnings += payment.totalPaymentsSum;
            }
            if (state.payments.isEmpty) {
              return Center(
                child: Text(
                  'No Payments Found !',
                  style: ScreenConfig.theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.black),
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: ScreenConfig.screenSizeWidth,
                    height: ScreenConfig.screenSizeHeight * 0.2,
                    decoration: BoxDecoration(
                        color: ScreenConfig.theme.primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('Total Earnings',
                                style: ScreenConfig.theme.textTheme.titleLarge
                                    ?.copyWith(color: Colors.white)),
                            const SizedBox(height: 12),
                            Text('\$ ${totalEarnings.round()}',
                                style: ScreenConfig.theme.textTheme.titleLarge
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenConfig.screenSizeHeight * 0.74,
                  child: LazyLoadScrollView(
                    onEndOfPage: () {
                      take += 10;
                      DI.i<ProducerPaymentsBloc>().add(
                          GetProducerPayments(take: take, page: 1, search: ''));
                    },
                    child: ListView.builder(
                        itemCount: state.payments.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: WedfluencerCards.paymentCard(
                              payment: state.payments[index],
                              onTap: () {},
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          } else if (state is ProducerPaymentsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
