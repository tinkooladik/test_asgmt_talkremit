abstract class Response<T> {
  String status;
  int code;
  String message;
  T data;

  Response(Map<String, dynamic> json) {
    this.status = json['status'];
    this.code = json['code'];
    this.message = json['message'];
    if (code == 200) {
      this.data = parseData(json['data']);
    }
  }

  T parseData(Map<String, dynamic> data);
}
