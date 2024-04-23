import 'dart:io';

import 'package:effective_coffee/src/features/locations/data/data_sources/locations_data_source.dart';
import 'package:effective_coffee/src/features/locations/data/data_sources/savable_locations_data_source.dart';
import 'package:effective_coffee/src/features/locations/models/DTOs/location_dto.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:effective_coffee/src/features/locations/utils/location_mapper.dart';

abstract interface class ILocationsRepository {
  Future<List<LocationModel>> loadLocations();
}

final class LocationsRepository implements ILocationsRepository {
  final ILocationsDataSource _networkLocationsDataSource;
  final ISavableLocationsDataSource _dbLocationsDataSource;

  const LocationsRepository({
    required ILocationsDataSource networkLocationsDataSource,
    required ISavableLocationsDataSource dbLocationsDataSource,
  })  : _networkLocationsDataSource = networkLocationsDataSource,
        _dbLocationsDataSource = dbLocationsDataSource;

  @override
  Future<List<LocationModel>> loadLocations() async {
    List<LocationDTO> dtos = <LocationDTO>[];
    try {
      dtos = await _networkLocationsDataSource.fetchLocations();
      _dbLocationsDataSource.saveLocations(locations: dtos);
    } on SocketException {
      dtos = await _dbLocationsDataSource.fetchLocations();
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
