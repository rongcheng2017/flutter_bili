import 'package:bili/http/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

///基础请求
abstract class BaseRequest {
  //查询参数  path参数
  var pathParams;
  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    //https和http切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if (needLogin()) {
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  //添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {
    'course-flag': 'fa',
    'auth-token': 'MjAyMC0wNi0yMyAwMzoyNTowMQ==fa'
  };
  //添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
