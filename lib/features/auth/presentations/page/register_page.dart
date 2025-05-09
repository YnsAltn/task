import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task/core/constants/endpoints.dart';
import 'package:task/features/auth/presentations/component/custom_text_field.dart';
import 'package:task/features/auth/presentations/provider/register_provider.dart';
import 'package:task/features/auth/validation.dart';
import 'package:task/core/theme/app_theme.dart';
import 'login_page.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    final notifier = ref.read(registerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Center(
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
                      LOGO_PATH,
                      height: 50.h,
                      width: 50.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 75.h),
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: TextStyle(fontSize: 16.sp, color: AppColors.black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.registerMessage,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    AppLocalizations.of(context)!.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    hintText: "John Doe",
                    validator: (value) => validateName(context, value),
                    onChanged: notifier.setName,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "E-mail",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    hintText: "john@mail.com",
                    validator: (value) => validateEmail(context, value),
                    onChanged: notifier.setEmail,
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
                    hintText: "● ● ● ● ● ● ● ●",
                    validator: (value) => validatePassword(context, value),
                    onChanged: notifier.setPassword,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  if (state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        state.errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await notifier.registerUser(context);
                        if (context.mounted) {
                          final message =
                              response != null
                                  ? AppLocalizations.of(
                                    context,
                                  )!.registerSuccess
                                  : AppLocalizations.of(context)!.registerFail;
                          final color =
                              response != null
                                  ? AppColors.green
                                  : AppColors.buttonColor;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: color,
                              duration: Duration(seconds: 1),
                            ),
                          );
                          if (response != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginPage()),
                            );
                          }
                        }
                      }
                    },
                    child:
                        state.isSubmitting
                            ? const CircularProgressIndicator()
                            : Text(AppLocalizations.of(context)!.register),
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
}
