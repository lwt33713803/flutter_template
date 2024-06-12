import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetTools;

class HttpClient {
  final Dio _dio = Dio();
  // 静态资源域名
  static const String _staticBaseUrl = 'http://3.106.224.41:8088/api';
  // 数据请求域名
  static const String _dataBaseUrl = "http://3.106.224.41:8088/api";

  HttpClient() {
    _dio.options.baseUrl = _dataBaseUrl;
    // 设置请求头，这里用于携带认证数据（例如令牌）
    // _dio.options.headers['Authorization'] = 'Bearer 123123';
    // 添加请求前拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Custom-Header'] = 'Custom-Value';
        return handler.next(options); // 继续请求
      },
    ));

    // 添加请求后拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        if (response.statusCode == 200) {
          return handler.next(response);
        } else {
          GetTools.Get.snackbar("错误", '错误');
          return handler.next(response.data);
        }
      },
    ));
  }

  // 配置静态资源域名
  void setStaticBaseUrl() {
    _dio.options.baseUrl = _staticBaseUrl;
  }

  // 配置数据请求域名
  void setDataBaseUrl() {
    _dio.options.baseUrl = _dataBaseUrl;
  }

  // 发起GET请求
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  // 发起POST请求
  Future<Response> post(String path, String s, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  // 发起多个请求
  Future<List<Response>> batchRequests(List<RequestOptions> requests) {
    final futures = requests.map((request) {
      final options = Options(
        method: request.method,
        headers: request.headers,
        responseType: ResponseType.json, // 设置响应类型
      );
      return _dio.request(request.path, options: options, data: request.data);
    }).toList();

    return Future.wait(futures);
  }
}
