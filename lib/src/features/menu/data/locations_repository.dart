import 'dart:io';

import 'package:effective_coffee/src/features/menu/data/data_sources/locations_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/savable_locations_data_source.dart';
import 'package:effective_coffee/src/features/menu/models/DTOs/location_dto.dart';
import 'package:effective_coffee/src/features/menu/models/location_model.dart';
import 'package:effective_coffee/src/features/menu/utils/location_mapper.dart';

abstract interface class ILocationsRepository {
  Future<List<LocationModel>> loadLocations();
}

final class LocationsRepository implements ILocationsRepository {
  final ILocationsDataSource _networkLocationsDataSource;
  final ISavableLocationsDataSource _dbLocationsDataSource;

  const LocationsRepository({
    required ILocationsDataSource networkLocationsDataSource,
    required ISavableLocationsDataSource dbLocationsDataSource,
  }) : _networkLocationsDataSource = networkLocationsDataSource,
      _dbLocationsDataSource = dbLocationsDataSource;

  @override
  Future<List<LocationModel>> loadLocations() async {
    var dtos = <LocationDTO>[];
    try {
      dtos = await _networkLocationsDataSource.fetchLocations();
      _dbLocationsDataSource.saveLocations(locations: dtos);
    } on SocketException {
      dtos = await _dbLocationsDataSource.fetchLocations();
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
