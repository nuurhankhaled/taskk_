import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/widgets/custom_text_form_field.dart';
import 'package:test_project/features/auth/presentation/pages/widgets/forget_password.dart';

class EmailAndPasswordWidget extends StatefulWidget {
  const EmailAndPasswordWidget({super.key});

  @override
  State<EmailAndPasswordWidget> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<EmailAndPasswordWidget> {
  bool isObsecure = true;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final loginCubit = context.read<LoginCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: AutofillGroup(
        child: Form(
          // key: loginCubit.formkey,
          child: Column(
            spacing: 2,
            children: [
              CustomTextFormField(
                borderWidth: 0.5,
                // borderColor: AppColors.lightBlueFillColor,
                // backgroundColor: AppColors.lightBlueFillColor,
                autofillHints: const [AutofillHints.username], // or email
                // controller: loginCubit.emailController,
                keyboardType: TextInputType.emailAddress,
                // validator: (value) {
                //   if (value!.isEmpty || !AppRegex.isEmailValid(value)) {
                //     return "signin.emailIsRequiredToLogin".tr();
                //   }
                //   return null;
                // },
                labelText: "Email",
              ),
              CustomTextFormField(
                borderWidth: 0.5,
                // borderColor: AppColors.lightBlueFillColor,
                // backgroundColor: AppColors.lightBlueFillColor,
                foucseNode: _focusNode,
                autofillHints: const [AutofillHints.password],
                // controller: loginCubit.passwordController,
                labelText: "password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: isObsecure,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is required to login";
                  }
                  return null;
                },
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    icon: Icon(
                      isObsecure ? Icons.visibility_off : Icons.visibility,
                    ),
                    // color: (_isFocused)
                    //     ? AppColors.primaryColor
                    //     : Colors.grey.shade500,
                  ),
                ),
              ),
              ForgetPassWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
