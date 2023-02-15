abstract class HttpClient<T> {
  Future<T> get(String path);
}
