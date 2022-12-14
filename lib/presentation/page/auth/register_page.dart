import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:expense_tracker/config/app_asset.dart';
import 'package:expense_tracker/config/app_theme.dart';
import 'package:expense_tracker/data/source/source_user.dart';
import 'package:expense_tracker/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  register() async {
    if (formKey.currentState!.validate()) {
      await SourceUser.register(
        controllerName.text, 
        controllerEmail.text,
        controllerPassword.text,
      );
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
                              controller: controllerName,
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
                                hintText: 'Name',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            DView.spaceHeight(),
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
                                onTap: () => register(),
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 16),
                                  child: Text(
                                    'Sign Up',
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
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Text(
                              'Login',
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
