import 'package:bili/db/HiCache.dart';
import 'package:bili/http/core/hi_net.dart';
import 'package:bili/http/request/base_request.dart';
import 'package:bili/http/request/login_request.dart';
import 'package:bili/http/request/registration_request.dart';

/// 数据访问对象
class LoginDao {
  static const BOARDING_PASS = 'boarding-pass';

  static login(String username, String pwd) {
    return _send(username, pwd);
  }

  static registration(
      String username, String pwd, String imoocId, String orderId) {
    return _send(username, pwd, imoocId: imoocId, orderId: orderId);
  }

  static _send(String username, String pwd,
      {String? imoocId, String? orderId}) async {
    BaseRequest request;

    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
      request.add('imoocId', imoocId).add('orderId', orderId);
    } else {
      request = LoginRequest();
    }

    var result = await HiNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      //保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
  }

  ///获取登录令牌
  static getBoardingPass() {
    HiCache.getInstance().get(BOARDING_PASS);
  }
}
