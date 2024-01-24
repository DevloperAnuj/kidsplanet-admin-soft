import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/fetch_members/fetch_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/searching/searching_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/pages/update_membership_page.dart';
import 'package:kidsplanetadmin/utils/service_locator.dart';

import '../../domain/entities/sub_member_entity.dart';
import '../manager/get_active_memberships/get_active_members_cubit.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchingCubit(),
        ),
        BlocProvider.value(
          value: serviceLocator.get<FetchMembersCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: AppBar(
                title: TextFormField(
                  onChanged: (text) {
                    context.read<SearchingCubit>().filterBySearch(text);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(),
                    hintText: 'Type User Name Or Phone number',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            BlocBuilder<SearchingCubit, SearchingState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.membersList.length,
                    itemBuilder: (context, index) {
                      final member = state.membersList[index];
                      return SearchUserListTile(
                        subMemberEntity: member,
                        index: index,
                      );
                    },
                    separatorBuilder: (c, i) {
                      return Divider(
                        indent: 50,
                        endIndent: 50,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ));
      }),
    );
  }
}

class SearchUserListTile extends StatelessWidget {
  final SubMemberEntity subMemberEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Text("${index + 1}"),
        ),
      ),
      title: SelectableText(
        subMemberEntity.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: SelectableText(
        "📮 ${subMemberEntity.addr}"
        "\n⭐ ${subMemberEntity.payid}"
        "\n📞 ${subMemberEntity.phone}"
        "\n📧 ${subMemberEntity.email}"
        "\n📅 Start: ${DateFormat.yMMMd().format(subMemberEntity.createdAt)} | End: ${DateFormat.yMMMd().format(subMemberEntity.subend)}",
      ),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 14,
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UpdateMembershipPage(
                subMemberEntity: subMemberEntity,
              ),
            ),
          );
        },
        icon: Icon(
          Icons.update,
        ),
      ),
    );
  }

  const SearchUserListTile({
    required this.subMemberEntity,
    required this.index,
  });
}
