import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000/api';

  Future<Map<String, dynamic>> registerUser(String userId, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'password': password}),
      );
      return _parseResponse(response);
    }
    catch (error) {
      return {'message': 'Network error: $error'};
    }
  }

  Future<Map<String, dynamic>> loginUser(String userId, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'password': password}),
      );
      return _parseResponse(response);
    }
    catch (error) {
      return {'message': 'Network error: $error'};
    }
  }

  Future<Map<String, dynamic>> createTask(String userId, String title, String description, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/task/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'title': title,
          'description': description,
        }),
      );
      return _parseResponse(response);
    }
    catch (error) {
      return {'message': 'Network error: $error'};
    }
  }

  Future<List<dynamic>> getTasks(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/task/all?userId=$userId'),
        headers: {'Content-Type': 'application/json'},
      );
      final data = _parseResponse(response);
      return data['tasks'] ?? [];
    }
    catch (error) {
      return [];
    }
  }

  Future<Map<String, dynamic>> updateTask({
    required String taskId,
    required String userId,
    String? title,
    String? description,
    String? status,
  }) async {
    try {
      final body = {
        'taskId': taskId,
        'userId': userId,
      };
      if (title != null) body['title'] = title;
      if (description != null) body['description'] = description;
      if (status != null) body['status'] = status;

      final response = await http.put(
        Uri.parse('$baseUrl/task/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _parseResponse(response);
    }
    catch (error) {
      return {'message': 'Network error: $error'};
    }
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
    try {
      final json = jsonDecode(response.body);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return {
          'message': json['message'] ?? 'Server error: ${response.statusCode}',
          ...json
        };
      }
      return json;
    }
    catch (error) {
      return {'message': 'Unexpected server response', 'status': response.statusCode};
    }
  }
}
