class ResponseModel {
  ResponseModel({
    this.status = ResponseStatus.pending,
    required this.message,
    this.data,
  });
  final ResponseStatus status;
  final String message;
  final dynamic data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'],
      data: json['AllCourses'],
    );
  }

  factory ResponseModel.fromSocketException() {
    return ResponseModel(
      status: ResponseStatus.socketExceptionError,
      message: 'Socket Exception Error',
    );
  }

  factory ResponseModel.fromUnknownError() {
    return ResponseModel(
      status: ResponseStatus.unknownError,
      message: 'Unknown Error',
    );
  }

  ResponseModel copyWith({
    ResponseStatus? status,
    String? message,
    Map<String, dynamic>? data,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

enum ResponseStatus {
  pending,
  successful,
  failed,
  socketExceptionError,
  unknownError,
}
