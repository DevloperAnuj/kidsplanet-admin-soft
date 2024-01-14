import 'package:bloc/bloc.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/fetch_members/fetch_members_cubit.dart';
import 'package:kidsplanetadmin/utils/service_locator.dart';

import '../../../domain/entities/sub_member_entity.dart';

part 'get_active_members_state.dart';

class GetActiveMembersCubit extends Cubit<GetActiveMembersState> {

  GetActiveMembersCubit() : super(GetActiveMembersState.initial());

  final fetchMemberCubit = serviceLocator.get<FetchMembersCubit>();

  late List<SubMemberEntity> _rawList = [];

  void getActiveMembers() {
    if (fetchMemberCubit.state.membersList == null) {
      emit(state.copyWith(membersList: _rawList));
    } else {
      final activeList = fetchMemberCubit.state.membersList!
          .where(
            (member) => member.subend.isAfter(DateTime.now()),
          )
          .toList();
      _rawList = activeList;
      emit(state.copyWith(membersList: _rawList));
    }
  }

  void fetchMembersByDateRange({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    print(fromDate);
    print(toDate);
    final filterList = _rawList
        .where((member) =>
            member.createdAt.isBefore(toDate) &&
            member.createdAt.isAfter(fromDate))
        .toList();
    emit(state.copyWith(membersList: filterList));
    print(filterList.length);
  }
}
