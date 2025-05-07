import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task/features/auth/presentation/providers/auth_provider.dart';
import 'package:task/features/home/presentation/pages/home_page.dart';
import 'package:task/features/theme/app_theme.dart';
import 'package:task/features/auth/presentation/components/custom_text_field.dart';
import 'package:task/features/auth/presentation/pages/register_page.dart';
import 'package:task/features/auth/validation.dart';

final checkboxProvider = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(checkboxProvider);

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
                      fit: BoxFit.contain,
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
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "John Doe",
                    validator: (value) => validateEmail(context, value),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: "● ● ● ● ● ● ● ●",
                    validator: (value) => validatePassword(context, value),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: isChecked,
                            onChanged:
                                (value) => _onCheckboxChanged(ref, value),
                          ),
                          TextButton(
                            onPressed:
                                () => _onCheckboxChanged(ref, !isChecked),
                            child: Text(
                              AppLocalizations.of(context)!.rememberMe,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          _goRegisterPage(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => _loginButton(context, ref),
                    child: Text(AppLocalizations.of(context)!.doLogin),
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

  void _loginButton(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final isChecked = ref.read(checkboxProvider);

      await ref
          .read(userProvider.notifier)
          .loginUser(email, password, isChecked);

      if (ref.read(userProvider) != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.loginFail)),
        );
      }
    }
  }
}

void _goRegisterPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegisterPage()),
  );
}

void _onCheckboxChanged(WidgetRef ref, bool? value) {
  ref.read(checkboxProvider.notifier).state = value ?? false;
}
