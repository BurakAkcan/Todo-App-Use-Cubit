import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/constants/strings.dart';

class NetworkService {
  Future<List<dynamic>?> getDatas() async {
    try {
      http.Response response = await http.get(Uri.parse(baseUrl + "/todos"));
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body) as List;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      //Burada yapılan işlem gelen patchObj(içerisinde Map yapısı var) bunu http.patch ile id si şu olan
      //todo elemanının o kısmını değiştir diyoruz.
      await http.patch(Uri.parse(baseUrl + "/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<dynamic>?> myFetchDatas1() async {
    try {
      final http.Response response =
          await http.get(Uri.parse(baseUrl + '/todos'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {}
  }

  Future<Map<String, dynamic>> addTodo(Map<String, String> todoObj) async {
    try {
      final response =
          await http.post(Uri.parse(baseUrl + '/todos'), body: todoObj);

      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }

  Future<bool?> deleteTodo(int? id) async {
    try {
      await http.delete(Uri.parse(baseUrl + 'todos/$id'));
      return true;
    } catch (e) {}
  }
}
