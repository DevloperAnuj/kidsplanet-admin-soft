import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kidsplanetadmin/features/membership_users/domain/entities/sub_member_entity.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/dispatching/dispatching_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/get_active_memberships/get_active_members_cubit.dart';
import 'package:kidsplanetadmin/features/wa_notifier/presentation/manager/wa_service.dart';

class OngoingList extends StatefulWidget {
  const OngoingList({super.key});

  @override
  State<OngoingList> createState() => _OngoingListState();
}

class _OngoingListState extends State<OngoingList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetActiveMembersCubit, GetActiveMembersState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.membersList.length,
          itemBuilder: (context, index) {
            final member = state.membersList[index];
            return OnUserListTile(
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
        );
      },
    );
  }
}

class OnUserListTile extends StatelessWidget {
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
      trailing: DispatchCheckBox(phone: subMemberEntity.phone),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }

  const OnUserListTile({
    required this.subMemberEntity,
    required this.index,
  });
}

class DispatchCheckBox extends StatelessWidget {
  const DispatchCheckBox({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DispatchingCubit, DispatchingState>(
      builder: (context, state) {
        return Checkbox(
          activeColor: Colors.green,
          checkColor: Colors.white,
          value: state.dispatchingList.contains(phone),
          onChanged: (val) {
            if (val!) {
              WAService.sendWhatsAppTemp(
                context,
                phone: phone,
                temp: "dispatch",
              ).then((value) {
                context.read<DispatchingCubit>().addToDispatchList(phone);
              });
            }
          },
        );
      },
    );
  }
}
