import 'package:get/get.dart';

void handleError(Response<dynamic> res) {
  if (res.hasError) {
    if (res.statusCode == 400) {
      // throw "Bad request!";
    } else if (res.statusCode == 404) {
      // throw "Resource not found";
    } else if (res.statusCode == 500) {
      throw "Internal server error";
    }

    print("Error: ${res.statusCode}, Body: ${res.body}");

    if (res.body != null) {
      if (res.body is Map && res.body.containsKey('message')) {
        throw res.body['message'];
      } else if (res.body is String) {
        throw res.body;
      }
    }
    throw "Connection Problem";
  }
}
