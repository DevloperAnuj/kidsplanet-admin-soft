import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/dispatching/dispatching_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/fetch_members/fetch_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/get_active_memberships/get_active_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/get_expired_memberships/get_exp_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/pages/add_member_page.dart';
import 'package:kidsplanetadmin/utils/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/expire_list.dart';
import '../widgets/ongoing_list.dart';
import 'search_user_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator.get<FetchMembersCubit>()..fetchAllMembers(),
        ),
        BlocProvider(
          create: (context) => serviceLocator.get<DispatchingCubit>(),
        ),
        BlocProvider(
          create: (context) => GetActiveMembersCubit()..getActiveMembers(),
        ),
        BlocProvider(
          create: (context) => GetExpMembersCubit()..getNonActiveMembers(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Kids Planet Admin"),
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.red,
            ),
            centerTitle: false,
            actions: [
              DateFilterWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ElevatedButton.icon(
                  label: const Text("Search User"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchUserPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ElevatedButton.icon(
                  label: const Text("Add User"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddMemberPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              const FetchingMembers(),
              const MyTabBar(),
              const MyTabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMembersCubit, FetchMembersState>(
      builder: (context, state) {
        if (state.membersList == null) {
          return SizedBox.shrink();
        }
        return TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.calendar_month,
                color: Colors.green,
              ),
              text:
                  "OnGoing (${context.watch<GetActiveMembersCubit>().state.membersList.length})",
            ),
            Tab(
              icon: Icon(
                Icons.calendar_today,
                color: Colors.red,
              ),
              text:
                  "Expired (${context.watch<GetExpMembersCubit>().state.membersList.length})",
            ),
          ],
        );
      },
    );
  }
}

class DateFilterWidget extends StatelessWidget {
  const DateFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ElevatedButton.icon(
        label: Text("Choose Date Range"),
        onPressed: () {
          showDateRangePicker(
            context: context,
            firstDate: DateTime(2023, 4, 1),
            lastDate: DateTime.now(),
          ).then((pickedDate) {
            if (pickedDate != null) {
              context.read<GetActiveMembersCubit>().fetchMembersByDateRange(
                    toDate: pickedDate.end,
                    fromDate: pickedDate.start,
                  );
            } else {
              context.read<GetActiveMembersCubit>().getActiveMembers();
            }
          });
        },
        icon: const Icon(Icons.date_range),
      ),
    );
  }
}

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMembersCubit, FetchMembersState>(
      builder: (context, state) {
        if (state.membersList == null) {
          return SizedBox.shrink();
        }
        return Expanded(
          child: const TabBarView(
            children: [
              OngoingList(),
              ExpiredList(),
            ],
          ),
        );
      },
    );
  }
}

class FetchingMembers extends StatelessWidget {
  const FetchingMembers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMembersCubit, FetchMembersState>(
      builder: (context, state) {
        if (state.errorMessage != null) {
          return Center(
            child: Icon(Icons.error),
          );
        }
        if (state.membersList != null) {
          return SizedBox.shrink();
        }
        return LinearProgressIndicator();
      },
    );
  }
}
