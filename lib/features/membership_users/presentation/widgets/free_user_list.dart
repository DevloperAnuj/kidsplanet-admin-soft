import 'package:flutter/material.dart';
import 'package:kidsplanetadmin/features/wa_notifier/presentation/manager/wa_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../pages/detail_user_page.dart';

class FreeUserList extends StatefulWidget {
  const FreeUserList({super.key});

  @override
  State<FreeUserList> createState() => _FreeUserListState();
}

class _FreeUserListState extends State<FreeUserList> {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  List usersList = [];

  Future<void> getUsersFromDatabase() async {
    final response = await supabaseClient
        .from('users')
        .select()
        .eq('payid', "Free NewsLetter");
    usersList = response;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsersFromDatabase(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, index) {
            return FreeUserListTile(
              name: usersList[index]['name'],
              phone: usersList[index]['phone'],
              address: usersList[index]['addr'],
              email: usersList[index]['email'],
              payId: usersList[index]['payid'],
              expDate: DateTime.parse(usersList[index]['subend']),
              crtDate: DateTime.parse(usersList[index]['created_at']),
            );
          },
        );
      },
    );
    ;
  }
}

class FreeUserListTile extends StatelessWidget {
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
      leading: const CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.person),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(phone),
      trailing: ElevatedButton.icon(
        label: const Text("Ping"),
        onPressed: () {
          WAService.sendWhatsAppTemp(context, phone: phone, temp: "ping");
        },
        icon: const Icon(
          Icons.notifications_active,
          color: Colors.blue,
        ),
      ),
    );
  }

  const FreeUserListTile({
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
