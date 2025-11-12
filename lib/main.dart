import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- 1. IMPORT FIREBASE CORE
import 'firebase_options.dart'; // <-- 2. IMPORT FILE YANG DIBUAT TADI

void main() async {
  // 3. PASTIKAN WIDGETS SUDAH SIAP [cite: 743]
  WidgetsFlutterBinding.ensureInitialized(); 

  // 4. INISIALISASI FIREBASE [cite: 743]
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dapur Pintar',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}