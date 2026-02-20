abstract class ApiServices {
  Future<dynamic> get(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> post(
    String endPoint, {
    Map<String, dynamic> queryParameters,
    Object? data,
    bool isFormData = false,
  });
}
