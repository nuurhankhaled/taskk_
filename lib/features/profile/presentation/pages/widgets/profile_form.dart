import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/widgets/custom_text_form_field.dart';
import 'package:test_project/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: cubit.firstNameController,
          labelText: 'First Name',
          borderWidth: 0.5,
          validator: (value) => value!.isEmpty ? 'Enter first name' : null,
        ),
        16.0.height(),

        CustomTextFormField(
          controller: cubit.lastNameController,
          labelText: 'Last Name',
          borderWidth: 0.5,
          validator: (value) => value!.isEmpty ? 'Enter last name' : null,
        ),
        16.0.height(),

        CustomTextFormField(
          controller: cubit.mobileController,
          labelText: 'Mobile Number',
          keyboardType: TextInputType.phone,
          borderWidth: 0.5,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          validator: (value) =>
              value!.length < 11 ? 'Enter valid mobile number' : null,
        ),
        16.0.height(),

        CustomTextFormField(
          labelText: 'Email',
          borderWidth: 0.5,
          readOnly: true,
          fillColor: Colors.grey.shade100,
          controller: TextEditingController(
            text: cubit.currentUser?.email ?? '',
          ),
          suffixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        ),
      ],
    );
  }
}
