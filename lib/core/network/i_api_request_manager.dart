abstract class IApiRequestManager {
  Future<dynamic> getRequest(
      {required String path, required Map<String, dynamic> parameters});

  Future<dynamic> postRequest(
      {required String path, Map<String, dynamic> parameters, dynamic body});
}
