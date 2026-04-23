import 'package:flutter/material.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/widgets/custom_button.dart';
import 'package:test_project/features/auth/presentation/pages/widgets/create_account_widget.dart';
import 'package:test_project/features/auth/presentation/pages/widgets/email_and_password.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              40.0.height(),
              // verticalSpace(40),
              // SignInTitle(),
              // verticalSpace(70),
              // GoogleButton(),
              // SignInDivider(),
              EmailAndPasswordWidget(),
              CustomButton(
                margin: EdgeInsets.symmetric(horizontal: 25),
                text: 'signin',
                onPressed: () {
                  // validateThenLogin(context);
                },
                fontSize: 14,
                borderRadius: 30,
                height: 55,
              ),
              CreateAccountWidget(),
              // LoginBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  // void validateThenLogin(BuildContext context) {
  //   if (context.read<LoginCubit>().formkey.currentState!.validate()) {
  //     context.read<LoginCubit>().emitLoginStates();
  //   }
  // }
}
