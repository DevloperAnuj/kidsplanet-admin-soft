import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/get_expired_memberships/get_exp_members_cubit.dart';
import 'package:kidsplanetadmin/features/wa_notifier/presentation/manager/wa_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/sub_member_entity.dart';
import '../manager/dispatching/dispatching_cubit.dart';
import '../pages/detail_user_page.dart';

class ExpiredList extends StatefulWidget {
  const ExpiredList({super.key});

  @override
  State<ExpiredList> createState() => _ExpiredListState();
}

class _ExpiredListState extends State<ExpiredList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpMembersCubit, GetExpMembersState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.membersList.length,
          itemBuilder: (context, index) {
            final member = state.membersList[index];
            return OffUserListTile(
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

class ExpUserListTile extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String email;
  final String payId;
  final DateTime expDate;
  final DateTime crtDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailUserPage(
              name: name,
              phone: phone,
              address: address,
              email: email,
              payId: payId,
              expDate: expDate,
              crtDate: crtDate,
            ),
          ),
        );
      },
      leading: const CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.person),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(address),
      trailing: ElevatedButton.icon(
        label: const Text("Remind Subscription"),
        onPressed: () {
          WAService.sendWhatsAppTemp(context, phone: phone, temp: "reminder");
        },
        icon: const Icon(
          Icons.send_and_archive,
          color: Colors.red,
        ),
      ),
    );
  }

  const ExpUserListTile({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.payId,
    required this.expDate,
    required this.crtDate,
  });
}

class OffUserListTile extends StatelessWidget {
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
      trailing: ReminderCheckBox(phone: subMemberEntity.phone),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }

  const OffUserListTile({
    required this.subMemberEntity,
    required this.index,
  });
}

class ReminderCheckBox extends StatelessWidget {
  const ReminderCheckBox({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DispatchingCubit, DispatchingState>(
      builder: (context, state) {
        return Checkbox(
          activeColor: Colors.red,
          checkColor: Colors.white,
          value: state.dispatchingList.contains(phone),
          onChanged: (val) {
            if (val!) {
              WAService.sendWhatsAppTemp(
                context,
                phone: phone,
                temp: "reminder",
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
