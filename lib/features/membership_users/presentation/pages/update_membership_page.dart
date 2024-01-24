import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/sub_member_entity.dart';
import '../manager/update_membership/update_membership_cubit.dart';

class UpdateMembershipPage extends StatefulWidget {
  final SubMemberEntity subMemberEntity;

  @override
  State<UpdateMembershipPage> createState() => _UpdateMembershipPageState();

  const UpdateMembershipPage({
    required this.subMemberEntity,
  });
}

class _UpdateMembershipPageState extends State<UpdateMembershipPage> {
  final List<String> _membershipLevelsList = [
    "1 Month",
    "3 Months",
    "6 Months",
    "1 Year"
  ];

  String _selectedLevel = "1 Month";
  DateTime _dateTime = DateTime.now();
  DateTime _upToDate = DateTime.now().add(Duration(days: 30));

  void setUpToDate(DateTime selectedDate) {
    _dateTime = selectedDate;
    if (_selectedLevel == "1 Month") {
      setState(() {
        _upToDate = _dateTime.add(Duration(days: 30));
      });
    } else if (_selectedLevel == "3 Months") {
      setState(() {
        _upToDate = _dateTime.add(Duration(days: 90));
      });
    } else if (_selectedLevel == "6 Months") {
      setState(() {
        _upToDate = _dateTime.add(Duration(days: 180));
      });
    } else if (_selectedLevel == "1 Year") {
      setState(() {
        _upToDate = _dateTime.add(Duration(days: 365));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateMembershipCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Update Member"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.subMemberEntity.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.subMemberEntity.phone,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(2022),
                    lastDate: DateTime.now(),
                  ).then((dateValue) {
                    if (dateValue != null) {
                      setState(() {
                        setUpToDate(dateValue);
                      });
                    }
                  });
                },
                child: Container(
                  child: Text(
                    "Starting Date  ${DateFormat.yMMMd().format(_dateTime)}",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SizedBox(
                height: 50,
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButton(
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _selectedLevel,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: _membershipLevelsList.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _selectedLevel = val!;
                          setUpToDate(_dateTime);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BlocConsumer<UpdateMembershipCubit, UpdateMembershipState>(
                listener: (context, state) {
                  if (state is UpdateMembershipSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("User Updated Successfully !"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpdateMembershipLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GFButton(
                    onPressed: () {
                      context.read<UpdateMembershipCubit>().updateToDatabase(
                            phone: widget.subMemberEntity.phone,
                            startDate: _dateTime,
                            endDate: _upToDate,
                          );
                    },
                    text: "Update Membership",
                    icon: Icon(
                      Icons.person_search_outlined,
                      color: Colors.white,
                    ),
                    fullWidthButton: true,
                    shape: GFButtonShape.pills,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
