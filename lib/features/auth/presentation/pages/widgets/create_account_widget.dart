import 'package:flutter/material.dart';
import 'package:test_project/core/theming/text_styles.dart';

class CreateAccountWidget extends StatelessWidget {
  const CreateAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyles.textStyle14.copyWith(fontSize: 12),
        ),
        TextButton(
          onPressed: () {
            // context.pushNamed(Routes.signupScreen);
          },
          child: Text(
            'Create Account',
            style: TextStyles.textStyle12.copyWith(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
