import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController(apiService: ApiService()));
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed('/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        productController.resetSearch();
                      } else {
                        productController.searchProducts(value);
                      }
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Obx(() {
            return Wrap(
              spacing: 8.0,
              children: productController.categories.map((category) {
                return FilterChip(
                  label: Text(category),
                  selected: productController.selectedCategory.value == category,
                  onSelected: (isSelected) {
                    if (isSelected) {
                      productController.selectCategory(category);
                    } else {
                      productController.selectCategory('');
                    }
                  },
                );
              }).toList(),
            );
          }),
          Expanded(
            child: Obx(() {
              var productsToShow = productController.searchResults.isEmpty
                  ? productController.products
                  : productController.searchResults;
              if (productController.isLoading.value && productsToShow.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else if (productsToShow.isEmpty) {
                return Center(child: Text('No products found'));
              } else {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!productController.isLoading.value &&
                        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                        productController.isMoreDataAvailable.value) {
                      productController.fetchProducts();
                      return true;
                    }
                    return false;
                  },
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: productsToShow.length + (productController.isMoreDataAvailable.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == productsToShow.length) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final product = productsToShow[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/product/${product.id}', arguments: product);
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
