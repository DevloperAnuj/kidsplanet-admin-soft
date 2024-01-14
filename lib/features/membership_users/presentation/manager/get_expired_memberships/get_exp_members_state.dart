part of 'get_exp_members_cubit.dart';

class GetExpMembersState {

  final List<SubMemberEntity> membersList;

  const GetExpMembersState({
    required this.membersList,
  });

  factory GetExpMembersState.initial(){
    return GetExpMembersState(membersList: []);
  }

  GetExpMembersState copyWith({
    List<SubMemberEntity>? membersList,
  }) {
    return GetExpMembersState(
      membersList: membersList ?? this.membersList,
    );
  }
}


