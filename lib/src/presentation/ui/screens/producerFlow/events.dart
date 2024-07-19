import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/producerEvent/producer_events_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/producerFlow/create_event.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../config/helper.dart';
import '../../templates/cards.dart';
import '../../templates/headings.dart';
import '../../templates/khairyat_appbar.dart';
import 'event_details.dart';

class WeddingProducerEventsScreen extends StatelessWidget {
  const WeddingProducerEventsScreen({super.key});
  static final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int take = 10;
    return Scaffold(
      backgroundColor: ScreenConfig.theme.scaffoldBackgroundColor,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: false,
        context: context,
        title: 'Events',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
                controller: search,
                hint: 'Search event',
                iconData: Icons.search_outlined,
                color: Colors.white,
                width: ScreenConfig.screenSizeWidth,
                onChanged: (val) {
                  DI
                      .i<ProducerEventsBloc>()
                      .add(GetProducerEvents(take: '10', search: val));
                }),
            WedfluencerDividers.transparentDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WedfluencerHeadings.generalHeading(
                  heading: 'Here are events/shows'.toUpperCase(),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      WedfluencerHelper.createRoute(
                          page: const CreateEventScreen()),
                    );
                  },
                  child: Icon(Icons.add_circle,
                      color: ScreenConfig.theme.primaryColor),
                ),
              ],
            ),
            WedfluencerDividers.transparentDivider(),
            BlocBuilder<ProducerEventsBloc, ProducerEventsState>(
              builder: (context, state) {
                if (state is GotProducerEvents) {
                  return SizedBox(
                    height: ScreenConfig.screenSizeHeight * 0.8,
                    child: LazyLoadScrollView(
                      onEndOfPage: () {
                        DI.i<ProducerEventsBloc>().add(GetProducerEvents(
                            take: '${take += 10}', search: ''));
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.events.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: WedfluencerCards.eventCard(
                              event: state.events[index],
                              onTap: () {
                                Navigator.of(context).push(
                                  WedfluencerHelper.createRoute(
                                    page: EventDetailsScreen(
                                      event: state.events[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
