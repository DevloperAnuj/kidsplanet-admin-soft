part of 'get_active_members_cubit.dart';

class GetActiveMembersState {

  final List<SubMemberEntity> membersList;

  const GetActiveMembersState({
    required this.membersList,
  });

  factory GetActiveMembersState.initial(){
    return GetActiveMembersState(membersList: []);
  }

  GetActiveMembersState copyWith({
    List<SubMemberEntity>? membersList,
  }) {
    return GetActiveMembersState(
      membersList: membersList ?? this.membersList,
    );
  }

}


