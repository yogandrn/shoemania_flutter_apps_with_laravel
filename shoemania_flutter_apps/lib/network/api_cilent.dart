import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoemania/utils/app_const.dart';

class ApiCLient {
  login(String email, String password) async {
    var body = {"email": email, "password": password};
    return await http.post(Uri.parse(BaseURL + "/login"),
        body: jsonEncode(body));
  }
}
