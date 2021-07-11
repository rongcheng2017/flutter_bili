import 'package:bili/http/core/hi_error.dart';
import 'package:bili/http/core/hi_net_adapter.dart';
import 'package:bili/http/request/base_request.dart';
import 'package:dio/dio.dart';

/// Dio适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    Response? response;
    DioError? error;
    var options = Options(headers: request.header);

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(request.url(), options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request) as HiNetResponse<T>;
  }

  ///构建HiNetResponse
  HiNetResponse buildRes(Response? response, BaseRequest request) {
    return HiNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode ?? -1,
        statusMessage: response?.statusMessage,
        extra: response);
  }
}
