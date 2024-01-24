import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../utils/service_locator.dart';

part 'update_membership_state.dart';

class UpdateMembershipCubit extends Cubit<UpdateMembershipState> {

  UpdateMembershipCubit() : super(UpdateMembershipInitial());

  final supabaseClient = serviceLocator.get<SupabaseClient>();

  void updateToDatabase({
    required String phone,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(UpdateMembershipLoading());
    try {
      final response = await supabaseClient
          .from('users')
          .update({
            "created_at": startDate.toIso8601String(),
            "subend": endDate.toIso8601String(),
          })
          .eq("phone", phone)
          .select()
          .single();
      final encodedBody = jsonEncode(response);
      print(encodedBody);
      emit(UpdateMembershipSuccess());
    } on PostgrestException catch (e) {
      print(e.message);
      emit(UpdateMembershipError(err: e.message));
    } catch (e) {
      emit(UpdateMembershipError(err: "Internal Error"));
    }
  }
}
