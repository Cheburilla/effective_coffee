class LocationDTO {
  final String address;
  final double lat;
  final double lng;

  const LocationDTO({
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory LocationDTO.fromJSON(Map<String, dynamic> json) {
    return LocationDTO(
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
