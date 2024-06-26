import 'package:effective_coffee/src/common/database/database.dart';
import 'package:effective_coffee/src/features/locations/data/data_sources/locations_data_source.dart';
import 'package:effective_coffee/src/features/locations/models/DTOs/location_dto.dart';

abstract interface class ISavableLocationsDataSource
    implements ILocationsDataSource {
  Future<void> saveLocations({required List<LocationDTO> locations});
}

final class DbLocationsDataSource implements ISavableLocationsDataSource {
  final AppDatabase _db;

  const DbLocationsDataSource({required AppDatabase db}) : _db = db;

  @override
  Future<List<LocationDTO>> fetchLocations() async {
    final result = await (_db.select(_db.locations)).get();
    return List<LocationDTO>.of(
      result
          .map((location) => LocationDTO.fromDB(location)),
    );
  }

  @override
  Future<void> saveLocations({required List<LocationDTO> locations}) async {
    for (LocationDTO location in locations) {
      _db.into(_db.locations).insertOnConflictUpdate(
            LocationsCompanion.insert(
              address: location.address,
              lat: location.lat,
              lng: location.lng,
            ),
          );
    }
  }
}
