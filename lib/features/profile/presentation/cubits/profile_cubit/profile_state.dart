part of 'profile_cubit.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileFailed extends ProfileState {
  final String error;
  const ProfileFailed(this.error);
}
