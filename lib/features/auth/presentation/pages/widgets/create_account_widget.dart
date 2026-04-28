import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/core/theming/text_styles.dart';

enum AccountState { login, signup }

class AccountStateWidget extends StatelessWidget {
  const AccountStateWidget({super.key, required this.accountState});
  final AccountState accountState;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(accountState == AccountState.login ? "Don't have an account?".tr() : "Already have an account?".tr(), style: TextStyles.textStyle14.copyWith(fontSize: 12)),
        TextButton(
          onPressed: () {
            context.pushReplacementNamed((accountState == AccountState.login) ? Routes.signupPage : Routes.loginPage);
          },
          child: Text(
            accountState == AccountState.login ? 'Create Account'.tr() : 'login'.tr(),
            style: TextStyles.textStyle12.copyWith(color: Colors.deepPurpleAccent, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
