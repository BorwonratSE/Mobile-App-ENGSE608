import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiService {
  static const _url = 'https://fakestoreapi.com/users';

  Future<List<dynamic>> fetchUsers() async {
    final res = await http.get(Uri.parse(_url));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    throw Exception('Failed to load users');
  }
}
