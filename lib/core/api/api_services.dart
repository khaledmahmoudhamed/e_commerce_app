abstract class ApiServices {
  Future<dynamic> getProducts(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
