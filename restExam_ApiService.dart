import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register.dart';

class RestApiService {
  static final RestApiService _restApiService = RestApiService._internal();
  factory RestApiService() => _restApiService;
  RestApiService._internal();

  Future<Register> postRegister(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://17ipogumzd.execute-api.us-west-2.amazonaws.com/dev/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'deviceId': 'ID.1234',
        'appName': 'test App',
      }),
    );

    if(response.statusCode == 201) {
      return Register.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<List<Register>> getRegisterList() async {
    final response = await http.get(
      Uri.parse('https://17ipogumzd.execute-api.us-west-2.amazonaws.com/dev/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final List<Register> result = jsonDecode(response.body)
      .map<Register>((json) => Register.fromJson(json))
      .toList();
    return result;
  }
}