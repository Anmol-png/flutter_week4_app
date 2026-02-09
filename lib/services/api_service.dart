import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  // Base URL for JSONPlaceholder API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Fetch all users
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/users'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Parse JSON response
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load users. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle different types of errors
      if (e.toString().contains('SocketException')) {
        throw Exception('No internet connection. Please check your network.');
      } else if (e.toString().contains('TimeoutException')) {
        throw Exception('Request timeout. Please try again.');
      } else {
        throw Exception('Error fetching users: ${e.toString()}');
      }
    }
  }

  // Fetch single user by ID
  Future<User> fetchUserById(int userId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/users/$userId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Failed to load user. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('No internet connection. Please check your network.');
      } else if (e.toString().contains('TimeoutException')) {
        throw Exception('Request timeout. Please try again.');
      } else {
        throw Exception('Error fetching user: ${e.toString()}');
      }
    }
  }

  // Fetch posts for a specific user (bonus feature)
  Future<List<dynamic>> fetchUserPosts(int userId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/posts?userId=$userId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
          'Failed to load posts. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('No internet connection. Please check your network.');
      } else if (e.toString().contains('TimeoutException')) {
        throw Exception('Request timeout. Please try again.');
      } else {
        throw Exception('Error fetching posts: ${e.toString()}');
      }
    }
  }
}
