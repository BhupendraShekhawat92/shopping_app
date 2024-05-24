import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';

class ApiService {
  static const baseUrl = 'https://fakestoreapi.com';

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Product>> getProducts({int page = 1, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/products?limit=$limit&page=$page'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.cast<String>();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProducts({int page = 1, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/products?limit=$limit&page=$page'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category, {int page = 1, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/products/category/$category?limit=$limit&page=$page'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }

}
