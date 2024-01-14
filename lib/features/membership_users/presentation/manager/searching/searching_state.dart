part of 'searching_cubit.dart';

class SearchingState {

  final List<SubMemberEntity> membersList;

  const SearchingState({
    required this.membersList,
  });

  factory SearchingState.initial(){
    return SearchingState(membersList: []);
  }

  SearchingState copyWith({
    List<SubMemberEntity>? membersList,
  }) {
    return SearchingState(
      membersList: membersList ?? this.membersList,
    );
  }
}


