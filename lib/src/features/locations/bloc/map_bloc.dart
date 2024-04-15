import 'package:effective_coffee/src/features/locations/data/locations_repository.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

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
    var location = event.location;
    emit(
      state.copyWith(currentLocation: location),
    );
  }

  Future<void> _onMapLoadingStarted(MapLoadingStarted event, emit) async {
    emit(
      state.copyWith(status: MapStatus.loading),
    );
    try {
      final locations = await _locationsRepository.loadLocations();
      emit(
        state.copyWith(locations: locations, status: MapStatus.idle, currentLocation: locations.first),
      );
      /*add(
        const PageLoadingStarted(), there can be an event to load current location from shared or adding first location from locations
      );*/
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
