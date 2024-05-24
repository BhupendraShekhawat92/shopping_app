import 'package:get/get.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final ApiService apiService;

  AuthController({required this.apiService});

  Future<void> login(String username, String password) async {
    try {
      final user = await apiService.login(username, password);
      if (user != null) {
        isLoggedIn.value = true;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
