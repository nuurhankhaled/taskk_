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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            EasyLoading.show();
          } else if (state is LoginFailure) {
            EasyLoading.dismiss();
            customToast(msg: "login Failed!", color: Colors.red);
          } else if (state is LoginSuccess) {
            TextInput.finishAutofillContext();
            EasyLoading.dismiss();
            customToast(msg: "login Success!", color: Colors.green);
            context.pushNamedAndRemoveUntil(
              Routes.mainlayoutScreen,
              (route) => false,
              predicate: (Route<dynamic> route) {
                return false;
              },
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  200.0.height(),
                  Text(
                    "Login into your Account",
                    style: TextStyles.textStyle18.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  50.0.height(),
                  EmailAndPasswordWidget(),
                  20.0.height(),
                  CustomButton(
                    color: Colors.deepPurple,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    text: 'signin',
                    onPressed: () {
                      validateThenLogin(context);
                    },
                    fontSize: 14,
                    borderRadius: 30,
                    height: 55,
                  ),
                  AccountStateWidget(accountState: AccountState.login),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void validateThenLogin(BuildContext context) {
    if (context.read<AuthCubit>().formkey.currentState!.validate()) {
      context.read<AuthCubit>().login();
    }
  }
}
