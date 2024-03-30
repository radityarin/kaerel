class BaseResponse<T> {
  final int status;
  final List<T> data;

  BaseResponse({
    required this.status,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return BaseResponse(
      status: json['status'] ?? 0,
      data: (json['data'] as List<dynamic>)
          .map((dynamic item) => fromJsonT(item))
          .toList(),
    );
  }
}
