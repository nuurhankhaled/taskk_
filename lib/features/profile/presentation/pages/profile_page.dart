import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/utility/custom_snack_bar.dart';
import 'package:test_project/core/widgets/custom_button.dart';
import 'package:test_project/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:test_project/features/profile/presentation/pages/widgets/profile_form.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              context.showSuccessSnackBar('Profile updated successfully');
            } else if (state is ProfileFailed) {
              context.showErrorSnackBar(state.error);
            }
          },
          builder: (context, state) {
            if (state is ProfileInitial || state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final cubit = context.read<ProfileCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  32.0.height(),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple.shade100,
                    child: Text(
                      cubit.currentUser?.firstName.isNotEmpty == true
                          ? cubit.currentUser!.firstName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  16.0.height(),
                  Text(
                    '${cubit.currentUser?.firstName ?? ''} ${cubit.currentUser?.lastName ?? ''}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  4.0.height(),
                  Text(
                    cubit.currentUser?.email ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  32.0.height(),
                  ProfileForm(cubit: cubit),
                  32.0.height(),
                  CustomButton(
                    color: Colors.deepPurple,
                    margin: EdgeInsets.zero,
                    text: 'Save Changes',
                    onPressed: () => cubit.updateProfile(),
                    fontSize: 14,
                    borderRadius: 30,
                    height: 55,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
