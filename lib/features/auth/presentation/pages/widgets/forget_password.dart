import 'package:flutter/material.dart';
import 'package:test_project/core/theming/text_styles.dart';

class ForgetPassWidget extends StatelessWidget {
  const ForgetPassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {},
      child: Text(
        "Forget Password?",
        style: TextStyles.textStyle14.copyWith(
          color: Colors.deepPurpleAccent,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
