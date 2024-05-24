import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var searchResults = <Product>[].obs;
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;
  var selectedCategory = ''.obs;
  var categories = ['jewelery', 'electronics', 'men\'s clothing', 'women\'s clothing'].obs;
  var currentPage = 1;
  final int itemsPerPage = 10;
  final ApiService apiService;

  ProductController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      var newProducts = await apiService.fetchProducts(page: currentPage, limit: itemsPerPage);
      if (newProducts.isEmpty) {
        isMoreDataAvailable.value = false;
      } else {
        products.addAll(newProducts);
        currentPage++;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    var results = products.where((p) => p.title.toLowerCase().contains(query.toLowerCase())).toList();
    searchResults.assignAll(results);
  }

  void resetSearch() {
    searchResults.clear();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    products.clear();
    currentPage = 1;
    fetchProductsByCategory(category);
  }

  void fetchProductsByCategory(String category) async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      var newProducts = await apiService.fetchProductsByCategory(category, page: currentPage, limit: itemsPerPage);
      if (newProducts.isEmpty) {
        isMoreDataAvailable.value = false;
      } else {
        products.addAll(newProducts);
        currentPage++;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
