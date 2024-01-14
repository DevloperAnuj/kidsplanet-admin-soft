import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../utils/service_locator.dart';
import '../../../domain/entities/sub_member_entity.dart';
import '../fetch_members/fetch_members_cubit.dart';

part 'get_exp_members_state.dart';

class GetExpMembersCubit extends Cubit<GetExpMembersState> {
  GetExpMembersCubit() : super(GetExpMembersState.initial());

  final fetchMemberCubit = serviceLocator.get<FetchMembersCubit>();

  void getNonActiveMembers() {
    if (fetchMemberCubit.state.membersList == null) {
      emit(state.copyWith(membersList: []));
    } else {
      final expList = fetchMemberCubit.state.membersList!
          .where(
            (member) => member.subend.isBefore(DateTime.now()),
          )
          .toList();
      emit(state.copyWith(membersList: expList));
    }
  }
}
