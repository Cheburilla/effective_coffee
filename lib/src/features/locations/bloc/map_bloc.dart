import 'package:effective_coffee/src/features/locations/data/locations_repository.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc(this._locationsRepository)
      : super(const MapState(locations: [], currentLocation: null)) {
    on<MapLocationChanged>(_onMapLocationChanged);
    on<MapLoadingStarted>(_onMapLoadingStarted);
  }

  final ILocationsRepository _locationsRepository;

  Future<void> _onMapLocationChanged(MapLocationChanged event, emit) async {
    LocationModel location = event.location;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('chosenAddress', location.address);
    emit(
      state.copyWith(currentLocation: location),
    );
  }

  Future<void> _onMapLoadingStarted(MapLoadingStarted event, emit) async {
    emit(
      state.copyWith(status: MapStatus.loading),
    );
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<LocationModel> locations = await _locationsRepository.loadLocations();
      final chosenAddress = prefs.getString('chosenAddress');
      LocationModel currentLocation = chosenAddress == null ? locations.first : locations.where((l) => l.address == chosenAddress).single;
      prefs.setString('chosenAddress', currentLocation.address);
      emit(
        state.copyWith(
            locations: locations,
            status: MapStatus.idle,
            currentLocation: currentLocation),
      );
    } on Object {
      emit(
        state.copyWith(status: MapStatus.error),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(status: MapStatus.idle),
      );
    }
  }
}
