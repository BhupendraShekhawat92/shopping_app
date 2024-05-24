import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../services/api_service.dart';
import 'product_list_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController(apiService: ApiService()));

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Obx(() {
        if (authController.isLoggedIn.value) {
          Future.microtask(() => Get.offAll(() => ProductListScreen()));
        }
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  authController.login(usernameController.text, passwordController.text);
                },
                child: Text('Login'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
