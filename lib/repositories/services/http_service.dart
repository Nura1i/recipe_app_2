import 'dart:convert';
import 'package:http/http.dart';
import 'package:recipe_app/models/Api%20Miliy%20Taom%20Model/card_http.dart';

class Network {
  static String BASE = "639c41a642e3ad69272bee27.mockapi.io";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static String API_LIST = "/user";
  static String API_CREATE = "/posts";
  static String API_UPDATE = "/posts/"; //{id}
  static String API_DELETE = "/posts/"; //{id}

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params); // http or https
    var response = await get(
      uri,
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    print(params.toString());
    var uri = Uri.https(BASE, api); // http or https
    var response = await post(uri, body: jsonEncode(params));
    // LogService.i(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  // static Future<String?> PUT(String api, Map<String, String> params) async {
  //   var uri = Uri.https(BASE, api); // http or https
  //   var response = await put(uri, headers: headers, body: jsonEncode(params));
  //   // LogService.i(response.body);
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return null;
  // }

  // static Future<String?> DEL(String api, Map<String, String> params) async {
  //   var uri = Uri.https(BASE, api, params); // http or https
  //   var response = await delete(uri, headers: headers);
  //   // LogService.i(response.body);
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return null;
  // }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  // static Map<String, String> paramsCreate(Post post) {
  //   Map<String, String> params = {};
  //   params.addAll({
  //     'name': post.name!,
  //     'about': post.about!,
  //     'userId': post.id.toString(),
  //     'photo': post.photo!
  //   });
  //   return params;
  // }

  // static Map<String, String> paramsUpdate(Post post) {
  //   Map<String, String> params = {};
  //   params.addAll({
  //     'name': post.name!,
  //     'about': post.about!,
  //     'userId': post.id.toString(),
  //     'photo': post.photo!
  //   });
  //   return params;
  // }

  /* Http Parsing */

  static List<Post> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }
}
