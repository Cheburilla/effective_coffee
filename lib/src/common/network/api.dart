class EffectiveAcademyApi {
  static const String _apiBaseUrl = 'coffeeshop.academy.effective.band';
  static const String _apiPath = '/api/v1/';

  Uri _buildUri(
      {required String endpoint,
      required Map<String, dynamic> Function() parametersBuilder}) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Uri locations({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'locations',
      parametersBuilder: () => queryParams(page, limit),
    );
  }

  Uri categories({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'products/categories',
      parametersBuilder: () => queryParams(page, limit),
    );
  }

  Uri products({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'products',
      parametersBuilder: () => queryParams(page, limit),
    );
  }

  Uri product(int id) {
    return _buildUri(
      endpoint: 'products/$id',
      parametersBuilder: () => {},
    );
  }

  Uri order() {
    return _buildUri(
      endpoint: 'orders',
      parametersBuilder: () => {},
    );
  }

  Map<String, dynamic> queryParams(int? page, int? limit) {
    return {'page': page ?? 0, 'limit': limit ?? 25};
  }
}
