part of 'update_membership_cubit.dart';

@immutable
abstract class UpdateMembershipState {}

class UpdateMembershipInitial extends UpdateMembershipState {}

class UpdateMembershipLoading extends UpdateMembershipState {}

class UpdateMembershipSuccess extends UpdateMembershipState {}

class UpdateMembershipError extends UpdateMembershipState {

  final String err;

  UpdateMembershipError({
    required this.err,
  });
}
