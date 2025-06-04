import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/firebase_options.dart';
import 'package:swiftnex/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:swiftnex/presentation/cart_screen/view/cart_screen.dart';
import 'package:swiftnex/presentation/checkout_screen/view/checkout_screen.dart';
import 'package:swiftnex/presentation/chnage_password_screen/view/change_password_screen.dart';
import 'package:swiftnex/presentation/history_details_screen/view/history_details_screen.dart';
import 'package:swiftnex/presentation/home_screen/view/home_screen.dart';
import 'package:swiftnex/presentation/order_screen/view/order_screen.dart';
import 'package:swiftnex/presentation/product_details_screen/view/product_details_screen.dart';
import 'package:swiftnex/presentation/settings_screen/view/settings_screen.dart';
import 'package:swiftnex/presentation/splash_screen/view/splash_screen.dart';
import 'package:swiftnex/presentation/tracking_screen/view/tracking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
