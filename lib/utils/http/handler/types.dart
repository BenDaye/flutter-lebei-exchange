class HttpResult<T> {
  HttpResult(
    this.status,
    this.message,
    this.success, {
    this.data,
    this.headers,
  });

  int status;
  String message;
  T? data;
  bool success;
  dynamic headers;
}
