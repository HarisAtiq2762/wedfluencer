import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wedfluencer/src/models/producer_event.dart';
import 'package:wedfluencer/src/presentation/ui/templates/coloredBoxed.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/dateFormatter.dart';
import '../../templates/khairyat_appbar.dart';

class ProducerEventsDetailsScreen extends StatelessWidget {
  final ProducerEvent event;

  const ProducerEventsDetailsScreen({super.key, required this.event});

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
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text(event.title!, style: ScreenConfig.theme.textTheme.bodyLarge),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildColoredBox(color: Color.fromARGB(255, 255, 199, 167), heading: "\$15", subTitle: 'Total Earning'),
                    BuildColoredBox(color: Color.fromARGB(255, 255, 186, 214), heading: "5", subTitle: 'No.of booths'),
                    BuildColoredBox(color: Color.fromARGB(255, 221, 255, 222), heading: "20", subTitle: 'No.of vendors'),
                    BuildColoredBox(color: Color.fromARGB(255, 205, 255, 247), heading: "0", subTitle: 'No.of brides'),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    markers: {
                      Marker(
                        markerId: const MarkerId('Wedding Show Location'),
                        position: LatLng(event.latitude ?? 0, event.longitude ?? 0),
                      ),
                    },
                    indoorViewEnabled: true,
                    initialCameraPosition: CameraPosition(
                      bearing: 90,
                      target: LatLng(event.latitude ?? 0, event.longitude ?? 0),
                      tilt: 59.440717697143555,
                      zoom: 15,
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildStyledBox(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WedfluencerDividers.transparentDividerForHeadings(),
                    WedfluencerDividers.transparentDivider(),
                    WedfluencerHeadings.generalHeading(heading: 'About'),
                    const SizedBox(height: 12),
                    Text(
                      event.description!,
                      style: ScreenConfig.theme.textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                    ),
                    WedfluencerDividers.transparentDividerForHeadings(),
                    WedfluencerHeadings.generalHeading(heading: 'Show Details'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Start Date',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventDate.format(event.startDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Start Time',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventHourFormat.format(event.startDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'End Date',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventDate.format(event.endDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'End Time',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            eventHourFormat.format(event.endDate!),
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Location',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: ScreenConfig.screenSizeWidth * 0.6,
                            child: Text(
                              event.location!,
                              style: ScreenConfig.theme.textTheme.bodySmall,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Location Detail',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: ScreenConfig.screenSizeWidth * 0.6,
                            child: Text(
                              event.locationDetail!,
                              style: ScreenConfig.theme.textTheme.bodySmall,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Referral Code',
                            style: ScreenConfig.theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: ScreenConfig.screenSizeWidth * 0.6,
                            child: Text(
                              event.referralCode!,
                              style: ScreenConfig.theme.textTheme.bodySmall,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    WedfluencerDividers.transparentDividerForHeadings(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 131, 198, 252),
                      Color.fromARGB(255, 216, 158, 226)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.title!, style: ScreenConfig.theme.textTheme.bodyLarge),
                          const SizedBox(height: 4),
                          Text(
                            'Referral code: ${event.referralCode}',
                            style: ScreenConfig.theme.textTheme.bodySmall!.copyWith(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Text(
                            'www.wedfluencer.com',
                            style: ScreenConfig.theme.textTheme.bodySmall!.copyWith(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Text("sdvjsdst"),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.08,
                      child: QrImageView(
                        data: event.referralCode!,
                        version: QrVersions.auto,
                        size: 80.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Edit button logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Edit'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Delete button logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledBox(BuildContext context, Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
