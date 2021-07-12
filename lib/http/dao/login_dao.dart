import 'package:bili/http/core/hi_net.dart';
import 'package:bili/http/request/base_request.dart';
import 'package:bili/http/request/login_request.dart';
import 'package:bili/http/request/registration_request.dart';

/// 数据访问对象
class LoginDao {
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
    request.add('userName', username).add('password', pwd);

    var result = await HiNet.getInstance().fire(request);
    print(result);
  }
}
