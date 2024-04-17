import 'package:effective_coffee/src/features/locations/bloc/map_bloc.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:effective_coffee/src/features/locations/view/widgets/location_bottomsheet.dart';
import 'package:effective_coffee/src/theme/image_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;

  CameraPosition? _userLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          await _initLocationLayer();
        },
        mapObjects: _getPlacemarkObjects(context),
        onUserLocationAdded: (view) async {
          _userLocation = await _mapController.getUserCameraPosition();
          if (_userLocation != null) {
            await _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                _userLocation!.copyWith(zoom: 15),
              ),
              animation: const MapAnimation(
                type: MapAnimationType.linear,
                duration: 0.3,
              ),
            );
          }
          return view.copyWith(
            pin: view.pin.copyWith(
              opacity: 1,
            ),
          );
        },
      ),
    );
  }

  Future<void> _initLocationLayer() async {
    final locationPermissionIsGranted =
        await Permission.location.request().isGranted;

    if (locationPermissionIsGranted) {
      await _mapController.toggleUserLayer(visible: true);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.noLocationPermission),
          ),
        );
      });
    }
  }
}

List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
  List<LocationModel>? locations = context.read<MapBloc>().state.locations;
  if (locations != null) {
    var points = locations
        .map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject ${point.address}'),
            point: Point(latitude: point.lat, longitude: point.lng),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  ImageSources.mapPoint,
                ),
                scale: 0.1,
              ),
            ),
            onTap: (_, __) => showModalBottomSheet(
              context: context,
              builder: (___) => BlocProvider.value(
                value: context.read<MapBloc>(),
                child: LocationBottomSheet(
                  location: point,
                ),
              ),
            ),
          ),
        )
        .toList();
    return points;
  } else {
    return [];
  }
}
