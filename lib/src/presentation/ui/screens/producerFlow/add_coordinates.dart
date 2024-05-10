import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wedfluencer/src/presentation/bloc/createEvent/create_event_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/producerFlow/producer_home.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../../models/producer_event.dart';
import '../../config/helper.dart';

class AddCoordinates extends StatefulWidget {
  final ProducerEvent event;

  const AddCoordinates({super.key, required this.event});

  @override
  State<AddCoordinates> createState() => _AddCoordinatesState();
}

class _AddCoordinatesState extends State<AddCoordinates> {
  LatLng latLng = const LatLng(0, 0);
  late GoogleMapController mapController;

  CameraPosition cameraPosition = const CameraPosition(
    bearing: 90,
    target: LatLng(0, 0),
    tilt: 59.440717697143555,
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    setLatLng();
  }

  void setLatLng() async {
    final locations = await locationFromAddress(widget.event.location!);
    setState(() {
      latLng = LatLng(locations[0].latitude, locations[0].longitude);
      cameraPosition = CameraPosition(
        bearing: 90,
        target: LatLng(locations[0].latitude, locations[0].longitude),
        tilt: 59.440717697143555,
        zoom: 15,
      );
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  void setLatLngViaDrag({required LatLng newLatLng}) async {
    print('setting');
    setState(() {
      latLng = newLatLng;
      cameraPosition = CameraPosition(
        bearing: 90,
        target: newLatLng,
        tilt: 0,
        zoom: 15,
      );
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WedfluencerAppbar.generalAppbar(
          title: widget.event.title!, context: context, showBackButton: true),
      body: BlocConsumer<CreateEventBloc, CreateEventState>(
          listener: (context, state) {
        if (state is EventCoordinatesUpdated) {
          Navigator.of(context).pushReplacement(
              WedfluencerHelper.createRoute(page: const ProducerHomeScreen()));
        }
      }, builder: (context, state) {
        if (state is CreateEventLoading) {
          return const CircularProgressIndicator();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: ScreenConfig.screenSizeHeight * 0.72,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: {
                  Marker(
                    draggable: true,
                    markerId: const MarkerId('Marker'),
                    position: latLng,
                    onDragEnd: (latLong) =>
                        setLatLngViaDrag(newLatLng: latLong),
                  ),
                },
                indoorViewEnabled: true,
                onTap: (position) => setLatLngViaDrag(newLatLng: position),
                initialCameraPosition: cameraPosition,
              ),
            ),
            WedfluencerButtons.fullWidthButton(
              text: 'Submit',
              textColor: Colors.white,
              func: () {
                BlocProvider.of<CreateEventBloc>(context).add(
                  UpdateEventCoordinates(
                    event: widget.event,
                    lat: latLng.latitude,
                    lng: latLng.longitude,
                  ),
                );
              },
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            )
          ],
        );
      }),
    );
  }
}
