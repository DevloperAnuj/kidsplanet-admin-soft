import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../wa_notifier/presentation/manager/wa_service.dart';

class DetailUserPage extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String email;
  final String payId;
  final DateTime expDate;
  final DateTime crtDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EntityRow(
            parameter: "Name",
            value: name,
          ),
          EntityRow(
            parameter: "Phone",
            value: phone,
          ),
          EntityRow(
            parameter: "Email",
            value: email,
          ),
          EntityRow(
            parameter: "Address",
            value: address,
          ),
          EntityRow(
            parameter: "PayId",
            value: payId,
          ),
          EntityRow(
            parameter: "Created Date",
            value: DateFormat('d MMM y').format(crtDate),
          ),
          EntityRow(
            parameter: "Subscription Expire",
            value: DateFormat('d MMM y').format(expDate),
          ),
          expDate.isBefore(DateTime.now())
              ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                    label: const Text("Remind Subscription"),
                    onPressed: () {
                      WAService.sendWhatsAppTemp(context, phone: phone, temp: "reminder");
                    },
                    icon: const Icon(
                      Icons.send_and_archive,
                      color: Colors.red,
                    ),
                  ),
              )
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                    label: const Text("Dispatch Notification"),
                    onPressed: () {
                      WAService.sendWhatsAppTemp(context, phone: phone, temp: "dispatch");
                    },
                    icon: const Icon(
                      Icons.send_time_extension,
                      color: Colors.green,
                    ),
                  ),
              ),
        ],
      ),
    );
  }

  const DetailUserPage({
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

class EntityRow extends StatelessWidget {
  final String parameter;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Text(
            "$parameter: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 20),
          SelectableText(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 3,
            minLines: 1,
          ),
        ],
      ),
    );
  }

  const EntityRow({
    super.key,
    required this.parameter,
    required this.value,
  });
}
