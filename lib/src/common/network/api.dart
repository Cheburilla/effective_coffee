class EffectiveAcademyApi {
  static const String _apiBaseUrl = 'coffeeshop.academy.effective.band';
  static const String _apiPath = '/api/v1/';

  Uri _buildUri({
    required String endpoint,
    required Map<String, String> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Uri locations({
    int? page,
    int? limit,
  }) {
    return _buildUri(
      endpoint: 'locations',
      parametersBuilder: () => queryParams(
        page: page,
        limit: limit,
      ),
    );
  }

  Uri categories({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'products/categories',
      parametersBuilder: () => queryParams(
        page: page,
        limit: limit,
      ),
    );
  }

  Uri products({
    int? category,
    int? page,
    int? limit,
  }) {
    return _buildUri(
      endpoint: 'products',
      parametersBuilder: () => queryParams(
        page: page,
        limit: limit,
        category: category,
      ),
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

  Map<String, String> queryParams({
    int? page,
    int? limit,
    int? category,
  }) {
    var params = {
      'page': page ?? 0,
      'limit': limit ?? 25,
    };
    if (category != null) {
      params.addAll({'category': category});
    }
    return params.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );
  }
}
