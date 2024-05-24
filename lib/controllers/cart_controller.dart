import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'dart:convert';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }

  void addToCart(Product product) {
    cartItems.add(product);
    saveCart();
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    saveCart();
  }

  void saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartList = cartItems.map((item) => jsonEncode(item)).toList();
    prefs.setStringList('cart', cartList);
  }

  void loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartList = prefs.getStringList('cart');
    if (cartList != null) {
      cartItems.assignAll(cartList.map((item) => Product.fromJson(jsonDecode(item))).toList());
    }
  }
}
