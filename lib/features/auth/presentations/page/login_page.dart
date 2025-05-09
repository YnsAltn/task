import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task/features/auth/presentations/component/custom_text_field.dart';
import 'package:task/features/auth/presentations/page/register_page.dart';
import 'package:task/features/auth/presentations/provider/login_provider.dart';
import 'package:task/features/auth/validation.dart';
import 'package:task/features/theme/app_theme.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.white,
            height: 690.h,
            width: 330.w,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Center(
                    child: SvgPicture.asset(
                      "assets/logo/logo.svg",
                      height: 50.h,
                      width: 50.w,
                    ),
                  ),
                  SizedBox(height: 75.h),
                  Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    style: TextStyle(fontSize: 16.sp, color: AppColors.black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.loginMessage,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    "E-mail",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "John Doe",
                    validator: (value) => validateEmail(context, value),
                    onChanged: loginNotifier.setEmail,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: "● ● ● ● ● ● ● ●",
                    validator: (value) => validatePassword(context, value),
                    onChanged: loginNotifier.setPassword,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: loginState.rememberMe,
                            onChanged:
                                (value) => loginNotifier.toggleRememberMe(
                                  value ?? false,
                                ),
                          ),
                          TextButton(
                            onPressed:
                                () => loginNotifier.toggleRememberMe(
                                  !loginState.rememberMe,
                                ),
                            child: Text(
                              AppLocalizations.of(context)!.rememberMe,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => _goRegisterPage(context),
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final success = await loginNotifier.loginUser(context);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? AppLocalizations.of(context)!.loginSuccess
                                    : AppLocalizations.of(context)!.loginFail,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor:
                                  success
                                      ? AppColors.green
                                      : AppColors.buttonColor,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      }
                    },
                    child:
                        loginState.isSubmitting
                            ? const CircularProgressIndicator()
                            : Text(AppLocalizations.of(context)!.doLogin),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }
}
