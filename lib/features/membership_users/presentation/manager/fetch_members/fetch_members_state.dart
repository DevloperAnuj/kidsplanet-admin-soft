part of 'fetch_members_cubit.dart';

class FetchMembersState {

  final List<SubMemberEntity>? membersList;
  final String? errorMessage;

  factory FetchMembersState.initial() {
    return FetchMembersState(membersList: null);
  }

  factory FetchMembersState.error({required String err}) {
    return FetchMembersState(errorMessage: err);
  }

  const FetchMembersState({
    this.membersList,
    this.errorMessage,
  });

  FetchMembersState copyWith({
    List<SubMemberEntity>? membersList,
    String? errorMessage,
  }) {
    return FetchMembersState(
      membersList: membersList ?? this.membersList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
