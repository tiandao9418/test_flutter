/// 返回结果类
class ModelBasic<T> {
  late final int code;
  late final String msg;
  final T? data;

  ModelBasic({required this.code, required this.msg, this.data});

  factory ModelBasic.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) dataFromJson,
  ) {
    return ModelBasic<T>(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: dataFromJson(json['data']),
    );
  }
}
