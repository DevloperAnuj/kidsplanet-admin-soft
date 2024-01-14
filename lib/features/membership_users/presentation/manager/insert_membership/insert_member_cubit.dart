import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../utils/service_locator.dart';

part 'insert_member_state.dart';

class InsertMemberCubit extends Cubit<InsertMemberState> {
  InsertMemberCubit() : super(InsertMemberInitial());

  final supabaseClient = serviceLocator.get<SupabaseClient>();

  void insertToDatabase({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String payId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(InsertMemberLoading());
    try {
      final response = await supabaseClient
          .from('users')
          .insert({
            "name": name,
            "phone": phone,
            "email": email,
            "addr": address,
            "created_at": startDate.toIso8601String(),
            "subend": endDate.toIso8601String(),
            "payid": payId,
          })
          .select()
          .single();
      final encodedBody = jsonEncode(response);
      print(encodedBody);
      emit(InsertMemberSuccess());
    } on PostgrestException catch (e) {
      print(e.message);
      emit(InsertMemberFailed(err: e.message));
    } catch (e) {
      emit(InsertMemberFailed(err: "Internal Error"));
    }
  }
}
