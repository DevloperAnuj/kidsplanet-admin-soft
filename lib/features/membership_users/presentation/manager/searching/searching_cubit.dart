import 'package:bloc/bloc.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/fetch_members/fetch_members_cubit.dart';
import 'package:kidsplanetadmin/utils/service_locator.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/sub_member_entity.dart';

part 'searching_state.dart';

class SearchingCubit extends Cubit<SearchingState> {
  SearchingCubit() : super(SearchingState.initial());

  final fetchMembersCubit = serviceLocator.get<FetchMembersCubit>();

  void filterBySearch(String searchText) {
    if (searchText.trim().isEmpty) {
      emit(state.copyWith(membersList: fetchMembersCubit.state.membersList));
    } else {
      final filterList = fetchMembersCubit.state.membersList!
          .where((member) =>
              member.name.toLowerCase().contains(searchText) ||
              member.phone.toLowerCase().contains(searchText))
          .toList();
      emit(state.copyWith(membersList: filterList));
    }
  }
}
