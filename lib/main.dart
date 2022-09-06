import 'package:expense_tracker/config/app_theme.dart';
import 'package:expense_tracker/config/session.dart';
import 'package:expense_tracker/data/model/user.dart';
import 'package:expense_tracker/presentation/page/auth/login_page.dart';
import 'package:expense_tracker/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID').then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.bg,
          foregroundColor: AppColor.white,
        ),
      ),
      home: FutureBuilder(
        future: Session.getUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.data != null && snapshot.data!.idUser != null) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
