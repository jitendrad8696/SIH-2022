import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_college/const/color_const.dart';
import 'package:my_college/const/string_const.dart';
import 'package:my_college/services/auth.dart';
import 'package:my_college/utils/app_sizes.dart';
import 'package:my_college/utils/no_leading_trailing_space_formatter.dart';
import 'package:my_college/views/pages/onboarding/forgot_password_page.dart';
import 'package:my_college/views/widgets/custom_app_bars/custom_app_bar_2.dart';
import 'package:my_college/views/widgets/custom_buttons/custom_button_1.dart';
import 'package:my_college/views/widgets/custom_text_form_fields/custom_text_form_field_1.dart';
import 'package:my_college/views/widgets/custom_titles/custom_title_1.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final AuthController _controller = Get.find();

  void signInWithEmail(BuildContext context) async {
    if (_key.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      await _controller.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
        context: context,
      );
    }
  }

  void onTap() {
    FocusManager.instance.primaryFocus!.unfocus();
    Get.to(() => ForgotPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar2,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: AppSizes.horizontalPadding20,
            child: Column(
              children: [
                SizedBox(height: AppSizes.height10 * 1.2),
                const CustomTitle1(text: StringConst.welcomeBack),
                SizedBox(height: AppSizes.height10 * 2),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _key,
                  child: Column(
                    children: [
                      CustomTextFormField1(
                        controller: _emailController,
                        maxLines: 1,
                        hintText: StringConst.email,
                        validator: (val) {
                          if (GetUtils.isEmail(val!)) {
                            return null;
                          } else {
                            return StringConst.validEmail;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [NoLeadingTrailingSpaceFormatter()],
                        obscureText: false,
                      ),
                      SizedBox(height: AppSizes.height10 * 2),
                      CustomTextFormField1(
                        controller: _passController,
                        maxLines: 1,
                        hintText: StringConst.password,
                        validator: (val) {
                          if (GetUtils.isLengthGreaterOrEqual(val!, 8)) {
                            return null;
                          } else {
                            return StringConst.enterYourPassword;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [NoLeadingTrailingSpaceFormatter()],
                        obscureText: true,
                      ),
                      SizedBox(height: AppSizes.height10 * 2)
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.height10 * 2),
                CustomButton1(
                    text: StringConst.signInWithEmail,
                    buttonColor: ColorConst.primaryColor,
                    textColor: ColorConst.whiteColor,
                    onTap: () {
                      signInWithEmail(context);
                    }),
                SizedBox(height: AppSizes.height10 * 4),
                GestureDetector(
                  child: Text(
                    StringConst.forgotYourPassword,
                    style: TextStyle(
                      fontSize: AppSizes.height10 * 1.8,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: onTap,
                ),
                SizedBox(height: AppSizes.height10 * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
