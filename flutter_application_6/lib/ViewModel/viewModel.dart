import 'package:flutter/material.dart';
import 'package:flutter_application_6/Model/LoginModel.dart';
import 'package:http/http.dart' as http;

class ViewModel with ChangeNotifier {
  List usersList = [];
  Future getLoginData() async {
    usersList.clear();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    var response = await http.get(url);
    var statusCode = response.statusCode;
    LoginModel loginModel = loginModelFromJson(response.body);
    print(loginModel.name.toString());
    usersList.add(loginModel);
    notifyListeners();
  }
}
