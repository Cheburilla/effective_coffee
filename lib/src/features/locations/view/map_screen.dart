import 'package:effective_coffee/src/features/locations/bloc/map_bloc.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:effective_coffee/src/features/locations/view/widgets/location_bottomsheet.dart';
import 'package:effective_coffee/src/features/locations/view/widgets/locations_list.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:effective_coffee/src/theme/image_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Point _omsk = Point(
  latitude: 54.98,
  longitude: 73.36,
);

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;
  late final List<PlacemarkMapObject> _points;
  CameraPosition? _userLocation;

  @override
  void initState() {
    super.initState();
    _points = _getPlacemarkObjects(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: _omsk,
                zoom: 10,
              ),
            ),
          );
          await _initLocationLayer();
        },
        mapObjects: _points,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            FloatingActionButton.small(
              onPressed: () => Navigator.pop(context),
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              heroTag: "btn1",
              child: const Icon(
                Icons.arrow_back,
                size: 20,
              ),
            ),
            const Spacer(),
            FloatingActionButton.small(
              onPressed: () => _navigateToLocationList(context),
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              heroTag: "btn2",
              child: const Icon(
                Icons.map_outlined,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }

  Future<void> _initLocationLayer() async {
    final bool locationPermissionIsGranted =
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

  List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
    List<LocationModel>? locations = context.read<MapBloc>().state.locations;
    if (locations != null) {
      List<PlacemarkMapObject> points = locations
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
                  anchor: const Offset(0.5, 1),
                  scale: 0.1,
                ),
              ),
              onTap: (_, __) => {
                _mapController.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: point.lat,
                        longitude: point.lng,
                      ),
                      zoom: 15,
                    ),
                  ),
                  animation: const MapAnimation(
                    type: MapAnimationType.linear,
                    duration: 0.3,
                  ),
                ),
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (___) => BlocProvider.value(
                    value: context.read<MapBloc>(),
                    child: LocationBottomSheet(
                      location: point,
                    ),
                  ),
                ),
              },
            ),
          )
          .toList();
      return points;
    } else {
      return [];
    }
  }

  Future<void> _navigateToLocationList(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<MapBloc>(),
          child: LocationsList(
            locations:
                context.read<MapBloc>().state.locations ?? <LocationModel>[],
          ),
        ),
      ),
    );
  }
}
