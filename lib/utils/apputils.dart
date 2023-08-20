import 'package:get/get.dart';

class AppUtils {
  // show snack bar
  static showSnackBar({required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}
