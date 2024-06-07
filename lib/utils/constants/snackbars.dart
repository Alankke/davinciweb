import 'package:davinciweb/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaVinciSnackBars {
  
  static void error(String message) {
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: DaVinciColors.error,
        colorText: DaVinciColors.textWhite,
        icon:
            const Icon(Icons.error_outline_rounded, color: DaVinciColors.white),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 5));
  }

  static void success(String message) {
    Get.snackbar('Éxito', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: DaVinciColors.success,
        colorText: DaVinciColors.textWhite,
        icon:
            const Icon(Icons.done_outline_rounded, color: DaVinciColors.white),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 5));
  }

  static void info(String message) {
    Get.snackbar('Información', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: DaVinciColors.info,
        colorText: DaVinciColors.textWhite,
        icon:
            const Icon(Icons.info_outline_rounded, color: DaVinciColors.white),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 5));
  }

  static void warning(String message) {
    Get.snackbar('Advertencia', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: DaVinciColors.warning,
        colorText: DaVinciColors.textPrimary,
        icon:
            const Icon(Icons.warning_amber_rounded, color: DaVinciColors.white),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 5));
  }
}
