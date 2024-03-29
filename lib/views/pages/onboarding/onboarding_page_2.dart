import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_college/const/color_const.dart';
import 'package:my_college/const/string_const.dart';
import 'package:my_college/controllers/create_profile_controller.dart';
import 'package:my_college/utils/app_sizes.dart';
import 'package:my_college/utils/no_leading_space_formatter.dart';
import 'package:my_college/utils/no_leading_trailing_space_formatter.dart';
import 'package:my_college/views/pages/onboarding/avatar_choose_page.dart';
import 'package:my_college/views/pages/onboarding/onboarding_page_3.dart';
import 'package:my_college/views/widgets/custom_app_bars/custom_app_bar_2.dart';
import 'package:my_college/views/widgets/custom_buttons/custom_button_1.dart';
import 'package:my_college/views/widgets/custom_text_form_fields/custom_text_form_field_1.dart';
import 'package:my_college/views/widgets/custom_titles/custom_title_1.dart';

class OnboardingPage2 extends StatelessWidget {
  OnboardingPage2({Key? key}) : super(key: key);

  final _controller = Get.put(CreateProfileController());

  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void onTap() {
    if (_key.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      _controller.updateUserName(_nameController.text.trim());
      _controller.updateUserDescription(_descriptionController.text.trim());
      Get.to(() => OnboardingPage3());
    }
  }

  void onTap2() {
    FocusManager.instance.primaryFocus!.unfocus();
    Get.to(() => AvatarChoosePage());
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.mediaQueryHeightWidth();
    return Scaffold(
      appBar: appBar2,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          child: Padding(
            padding: AppSizes.horizontalPadding20,
            child: Column(
              children: [
                SizedBox(height: AppSizes.height10),
                const CustomTitle1(text: StringConst.createProfile),
                SizedBox(height: AppSizes.height10 * 2),
                GestureDetector(
                  child: Stack(
                    children: [
                      Center(
                        child: Obx(
                          () => Image.asset(
                            _controller.avatarImageConst(),
                            height: AppSizes.height10 * 10,
                          ),
                        ),
                      ),
                      Positioned(
                        left: AppSizes.width10 * 20.5,
                        top: AppSizes.height10 * 6.7,
                        child: CircleAvatar(
                          backgroundColor: ColorConst.primaryColor,
                          radius: AppSizes.height10 * 1.5,
                          child: Icon(
                            Icons.create_rounded,
                            size: AppSizes.height10 * 2,
                            color: ColorConst.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: onTap2,
                ),
                SizedBox(height: AppSizes.height10 * 2),
                Form(
                  key: _key,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextFormField1(
                        controller: _nameController,
                        maxLines: 1,
                        hintText: StringConst.chooseUserName,
                        validator: (val) {
                          if (GetUtils.isUsername(val!)) {
                            return null;
                          } else {
                            return StringConst.chooseValidUserName;
                          }
                        },
                        keyboardType: TextInputType.name,
                        inputFormatters: [NoLeadingTrailingSpaceFormatter()],
                        obscureText: false,
                      ),
                      SizedBox(height: AppSizes.height10 * 2),
                      CustomTextFormField1(
                        controller: _descriptionController,
                        maxLines: 5,
                        hintText: StringConst.writeAboutYourself,
                        validator: (val) {
                          if (GetUtils.isLengthGreaterOrEqual(val, 20)) {
                            return null;
                          } else {
                            return StringConst.chooseValidDescription20;
                          }
                        },
                        keyboardType: TextInputType.text,
                        inputFormatters: [NoLeadingSpaceFormatter()],
                        obscureText: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.height10 * 4),
                CustomButton1(
                  text: StringConst.continueButtonString,
                  buttonColor: ColorConst.primaryColor,
                  textColor: ColorConst.whiteColor,
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
