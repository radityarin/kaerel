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
  factory BaseResponse.fromJsonA(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    var jsonData = json['data'];
    List<T> dataList = [];

    if (jsonData is List) {
      dataList = jsonData.map((dynamic item) => fromJsonT(item)).toList();
    } else if (jsonData is Map<String, dynamic>) {
      dataList.add(fromJsonT(jsonData));
    }

    return BaseResponse(
      status: json['status'] ?? 0,
      data: dataList,
    );
  }
}
