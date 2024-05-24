import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final CartController cartController = Get.find();
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    final productId = int.parse(Get.parameters['id']!);
    final Product product = productController.products.firstWhere((product) => product.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.image),
              SizedBox(height: 16),
              Text(
                product.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('\$${product.price}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              Text(product.description),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);
                  Get.snackbar('Success', 'Product added to cart');
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
