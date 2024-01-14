part of 'insert_member_cubit.dart';

@immutable
abstract class InsertMemberState {}

class InsertMemberInitial extends InsertMemberState {}

class InsertMemberLoading extends InsertMemberState {}

class InsertMemberSuccess extends InsertMemberState {}

class InsertMemberFailed extends InsertMemberState {
  final String err;

  InsertMemberFailed({
    required this.err,
  });
}
