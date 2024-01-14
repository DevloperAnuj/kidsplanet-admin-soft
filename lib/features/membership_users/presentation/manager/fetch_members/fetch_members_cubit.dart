import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:kidsplanetadmin/utils/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entities/sub_member_entity.dart';

part 'fetch_members_state.dart';

class FetchMembersCubit extends Cubit<FetchMembersState> {
  FetchMembersCubit() : super(FetchMembersState.initial());

  final supabaseClient = serviceLocator.get<SupabaseClient>();

  late List<SubMemberEntity> _rawList = [];

  void fetchAllMembers() async {
    emit(FetchMembersState.initial());
    try {
      final response = await supabaseClient
          .from('users')
          .select()
          .neq('payid', "Free NewsLetter");
      final encodedBody = jsonEncode(response);
      Iterable decodedBody = jsonDecode(encodedBody);
      final localMembersList =
          decodedBody.map((member) => SubMemberEntity.fromMap(member)).toList();
      _rawList = localMembersList;
      emit(state.copyWith(membersList: _rawList));
    } on PostgrestException catch (e) {
      print(e.message);
      emit(FetchMembersState.error(err: e.message));
    } catch (err) {
      emit(FetchMembersState.error(err: "Internal Error"));
    }
  }

}
