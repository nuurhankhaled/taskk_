import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/app_regex.dart';
import 'package:test_project/core/widgets/custom_text_form_field.dart';
import 'package:test_project/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, this.isSignup = false});
  final bool isSignup;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
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
    final authCubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AutofillGroup(
        child: Form(
          key: authCubit.formkey,
          child: Column(
            spacing: 2,
            children: [
              if (widget.isSignup) ...[
                CustomTextFormField(
                  borderWidth: 0.5,
                  controller: authCubit.firstNameController,
                  keyboardType: TextInputType.name,
                  labelText: 'First Name'.tr(),
                  validator: (value) => value!.isEmpty ? 'Enter first name'.tr() : null,
                ),
                CustomTextFormField(
                  borderWidth: 0.5,
                  controller: authCubit.lastNameController,
                  keyboardType: TextInputType.name,
                  labelText: 'Last Name'.tr(),
                  validator: (value) => value!.isEmpty ? 'Enter last name'.tr() : null,
                ),
                CustomTextFormField(
                  borderWidth: 0.5,
                  controller: authCubit.mobileController,
                  keyboardType: TextInputType.phone,
                  labelText: 'Mobile Number'.tr(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                  validator: (value) => value!.length < 11 ? 'Enter valid mobile number'.tr() : null,
                ),
              ],

              CustomTextFormField(
                borderWidth: 0.5,
                autofillHints: const [AutofillHints.username],
                controller: authCubit.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !AppRegex.isEmailValid(value)) {
                    return "Email is required".tr();
                  }
                  return null;
                },
                labelText: "Email".tr(),
              ),
              CustomTextFormField(
                borderWidth: 0.5,
                foucseNode: _focusNode,
                autofillHints: const [AutofillHints.password],
                controller: authCubit.passwordController,
                labelText: "Password".tr(),
                keyboardType: TextInputType.visiblePassword,
                obscureText: isObsecure,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is required".tr();
                  }
                  return null;
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    icon: Icon(isObsecure ? Icons.visibility_off : Icons.visibility),
                    color: _isFocused ? Colors.deepPurple : Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
