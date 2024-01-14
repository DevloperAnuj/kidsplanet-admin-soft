import 'package:get_it/get_it.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/dispatching/dispatching_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/fetch_members/fetch_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/get_active_memberships/get_active_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/get_date_range/get_date_range_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/get_expired_memberships/get_exp_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/searching/searching_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

void setupInit() {
  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  serviceLocator.registerLazySingleton<FetchMembersCubit>(
    () => FetchMembersCubit(),
  );

  serviceLocator.registerLazySingleton<GetActiveMembersCubit>(
    () => GetActiveMembersCubit(),
  );

  serviceLocator.registerLazySingleton<GetExpMembersCubit>(
    () => GetExpMembersCubit(),
  );

  serviceLocator.registerLazySingleton<GetDateRangeCubit>(
        () => GetDateRangeCubit(),
  );

  serviceLocator.registerLazySingleton<DispatchingCubit>(
        () => DispatchingCubit(),
  );

  serviceLocator.registerLazySingleton<SearchingCubit>(
        () => SearchingCubit(),
  );
}
