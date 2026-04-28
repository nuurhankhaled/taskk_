import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/auth/data/models/user_model.dart';
import 'package:test_project/features/auth/data/repo/auth_repo.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo _authRepo;

  ProfileCubit(this._authRepo) : super(ProfileInitial());

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController mobileController;

  UserModel? currentUser;

  void init() {
    final result = _authRepo.getUser();
    result.when(
      success: (user) {
        currentUser = user;
        firstNameController = TextEditingController(
          text: user?.firstName ?? '',
        );
        lastNameController = TextEditingController(text: user?.lastName ?? '');
        mobileController = TextEditingController(text: user?.mobile ?? '');
        emit(ProfileSuccess());
      },
      failure: (error) => emit(ProfileFailed(error)),
    );
  }

  Future<void> updateProfile() async {
    emit(ProfileLoading());
    final updatedUser = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: currentUser?.email ?? '',
      mobile: mobileController.text,
    );
    final result = await _authRepo.saveUser(updatedUser);
    result.when(
      success: (_) {
        currentUser = updatedUser;
        emit(ProfileUpdateSuccess());
      },
      failure: (error) => emit(ProfileFailed(error)),
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    return super.close();
  }
}
