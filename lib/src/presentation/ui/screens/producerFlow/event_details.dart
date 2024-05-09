import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wedfluencer/src/models/producer_event.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/dateFormatter.dart';
import '../../templates/khairyat_appbar.dart';

class EventDetailsScreen extends StatelessWidget {
  final ProducerEvent event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenConfig.theme.scaffoldBackgroundColor,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: true,
        context: context,
        title: 'Event Details',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenConfig.screenSizeHeight * 0.6,
              child: GoogleMap(
                markers: {
                  Marker(
                    markerId: const MarkerId('Wedding Show Location'),
                    position: LatLng(event.latitude!, event.longitude!),
                  ),
                },
                indoorViewEnabled: true,
                initialCameraPosition: CameraPosition(
                  bearing: 90,
                  target: LatLng(event.latitude!, event.longitude!),
                  tilt: 59.440717697143555,
                  zoom: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WedfluencerDividers.transparentDividerForHeadings(),
                  Text(event.title!,
                      style: ScreenConfig.theme.textTheme.bodyLarge),
                  WedfluencerDividers.transparentDivider(),
                  WedfluencerHeadings.generalHeading(heading: 'About'),
                  const SizedBox(height: 12),
                  Text(event.description!,
                      style: ScreenConfig.theme.textTheme.bodySmall),
                  WedfluencerDividers.transparentDividerForHeadings(),
                  WedfluencerHeadings.generalHeading(heading: 'Show Details'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Start Date',
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text(eventDate.format(event.startDate!),
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text('Start Time',
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text(eventHourFormat.format(event.startDate!),
                          style: ScreenConfig.theme.textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('End Date',
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text(eventDate.format(event.endDate!),
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text('End Time',
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text(eventHourFormat.format(event.endDate!),
                          style: ScreenConfig.theme.textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location',
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      SizedBox(
                        width: ScreenConfig.screenSizeWidth * 0.6,
                        child: Text(
                          event.location!,
                          style: ScreenConfig.theme.textTheme.bodySmall,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location Detail',
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text(event.locationDetail!,
                          style: ScreenConfig.theme.textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Referral Code',
                          style: ScreenConfig.theme.textTheme.bodySmall),
                      Text(event.referralCode!,
                          style: ScreenConfig.theme.textTheme.bodySmall),
                    ],
                  ),
                  WedfluencerDividers.transparentDividerForHeadings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
