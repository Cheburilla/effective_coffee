import 'package:effective_coffee/src/features/locations/models/DTOs/location_dto.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';

extension LocationMapper on LocationDTO {
  LocationModel toModel() =>
      LocationModel(address: address, lat: lat, lng: lng);
}
