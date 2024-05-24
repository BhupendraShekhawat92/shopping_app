import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/login_screen.dart';
import 'views/product_list_screen.dart';
import 'views/product_detail_screen.dart';
import 'views/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/products', page: () => ProductListScreen()),
        GetPage(name: '/product/:id', page: () => ProductDetailScreen()),
        GetPage(name: '/cart', page: () => CartScreen()),
      ],
    );
  }
}
