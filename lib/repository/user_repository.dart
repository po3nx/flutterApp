import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/user.dart';

class UserRepository {
  Future<String?> login(User user) async {
    final response = await http.post(
      Uri.parse('https://pung.pw/wa2/backend/api/login'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      final token = json.decode(response.body)['token'];
      return token;
    } else {
      return null;
      //throw Exception('Failed to login');
    }
  }

  Future<void> register(User user) async {
    final response = await http.post(
      Uri.parse('https://pung.pw/wa2/backend/api/register'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register');
    }
  }
}