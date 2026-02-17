abstract class ApiServices {
  Future<dynamic> getProducts(
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

  Future<dynamic> getProfileData(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  });
}
