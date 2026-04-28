import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/core/theming/text_styles.dart';
import 'package:test_project/core/utility/flutter_toast.dart';
import 'package:test_project/core/widgets/custom_button.dart';
import 'package:test_project/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:test_project/features/auth/presentation/pages/widgets/create_account_widget.dart';
import 'package:test_project/features/auth/presentation/pages/widgets/email_and_password.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            EasyLoading.show();
          } else if (state is SignupFailure) {
            EasyLoading.dismiss();
            customToast(msg: "signup Failed!".tr(), color: Colors.red);
          } else if (state is SignupSuccess) {
            TextInput.finishAutofillContext();
            EasyLoading.dismiss();
            customToast(msg: "signup Success!".tr(), color: Colors.green);
            context.pushNamedAndRemoveUntil(Routes.mainlayoutPage, (route) => false, predicate: (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  60.0.height(),
                  Text("Create Account".tr(), style: TextStyles.textStyle18.copyWith(fontWeight: FontWeight.w600)),
                  50.0.height(),

                  FormWidget(isSignup: true),
                  20.0.height(),
                  CustomButton(
                    color: Colors.deepPurple,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    text: 'signup'.tr(),
                    onPressed: () => validateThenSignup(context),
                    fontSize: 14,
                    borderRadius: 30,
                    height: 55,
                  ),
                  AccountStateWidget(accountState: AccountState.signup),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void validateThenSignup(BuildContext context) {
    if (context.read<AuthCubit>().formkey.currentState!.validate()) {
      context.read<AuthCubit>().signup();
    }
  }
}
