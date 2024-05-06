import 'package:davinciweb/app.dart';
import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //Widgets
  WidgetsFlutterBinding.ensureInitialized();

  //Get local storage
  await GetStorage.init();

  //Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  
  //Ejecuta finalmente
  runApp(const App());
}
