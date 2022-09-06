import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:expense_tracker/config/app_asset.dart';
import 'package:expense_tracker/config/app_theme.dart';
import 'package:expense_tracker/data/source/source_user.dart';
import 'package:expense_tracker/presentation/page/auth/register_page.dart';
import 'package:expense_tracker/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  login() async {
    if (formKey.currentState!.validate()) {
      bool success = await SourceUser.login(
        controllerEmail.text,
        controllerPassword.text,
      );
      if (success) {
        DInfo.dialogSuccess('Login Successfully!');
        DInfo.closeDialog(actionAfterClose: () {
          Get.off(() => const HomePage());
        });
      } else {
        DInfo.dialogError('Login Failed');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.bg,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DView.nothing(),
                    // Email and Password textfield and Login button
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Image.asset(AppAsset.logo),
                            DView.spaceHeight(40),
                            TextFormField(
                              controller: controllerEmail,
                              validator: (value) => value == ''
                                  ? 'This field cannnot be empty'
                                  : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                fillColor: AppColor.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Email',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            DView.spaceHeight(),
                            TextFormField(
                              controller: controllerPassword,
                              validator: (value) => value == ''
                                  ? 'This field cannnot be empty'
                                  : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText:
                                  true, //This is to hide text for password input
                              decoration: InputDecoration(
                                fillColor: AppColor.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                              ),
                            ),
                            DView.spaceHeight(30),
                            Material(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () => login(),
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 16),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Don't have account? container
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const RegisterPage());
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
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
      ),
    );
  }
}
