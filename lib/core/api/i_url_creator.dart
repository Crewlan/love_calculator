abstract class IUrlCreator {
  String create({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    List<String>? pathSegments,
    String scheme,
    String? hostKey,
    int? port,
  });
}
