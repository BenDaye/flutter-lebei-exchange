class HttpResult<T> {
  int status;
  String message;
  T? data;
  bool success;
  dynamic headers;

  HttpResult(
    this.status,
    this.message,
    this.success, {
    this.data,
    this.headers,
  });
}
