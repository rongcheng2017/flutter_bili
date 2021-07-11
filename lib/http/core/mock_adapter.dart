import 'package:bili/http/core/hi_net_adapter.dart';
import 'package:bili/http/request/base_request.dart';

/// 测试适配器 ，mock数据

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          data: {"code": 0, "message": "sucess"} as T?, statusCode: 200);
    });
  }
}