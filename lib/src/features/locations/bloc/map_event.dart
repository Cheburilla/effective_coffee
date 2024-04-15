part of 'map_bloc.dart';

@immutable
sealed class MapEvent extends Equatable {
  const MapEvent();
}

class MapLocationChanged extends MapEvent {
  final LocationModel location;
  const MapLocationChanged(
    this.location,
  );

  @override
  String toString() => 'MapLocationChanged { id: ${location.address} }';

  @override
  List<Object> get props => [
        location,
      ];
}

class MapLoadingStarted extends MapEvent {
  const MapLoadingStarted();

  @override
  String toString() => 'MapLoadingStarted';

  @override
  List<Object> get props => [];
}
