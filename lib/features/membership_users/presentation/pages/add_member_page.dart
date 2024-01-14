import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/fetch_members/fetch_members_cubit.dart';
import 'package:kidsplanetadmin/features/membership_users/presentation/manager/insert_membership/insert_member_cubit.dart';
import 'package:kidsplanetadmin/utils/service_locator.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final List<String> _membershipLevelsList = [
    "1 Month",
    "3 Months",
    "6 Months",
    "1 Year"
  ];

  String _selectedLevel = "1 Month";
  DateTime _dateTime = DateTime.now();
  DateTime _upToDate = DateTime.now().add(Duration(days: 30));

  void setUpToDate() {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InsertMemberCubit(),
        ),
        BlocProvider.value(
          value: serviceLocator.get<FetchMembersCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Member"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              AddMemberTextField(
                controller: _nameController,
                hintText: "Type User Name",
                prefixIcon: Icon(Icons.person),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2022),
                      lastDate: _dateTime,
                    ).then((dateValue) {
                      if (dateValue != null) {
                        setUpToDate();
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
                            setUpToDate();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              AddMemberTextField(
                controller: _phoneController,
                hintText: "Type User Phone",
                prefixIcon: Icon(Icons.phone),
              ),
              AddMemberTextField(
                controller: _addressController,
                hintText: "Type User Address",
                prefixIcon: Icon(Icons.pin_drop),
              ),
              AddMemberTextField(
                controller: _emailController,
                hintText: "Type User Email",
                prefixIcon: Icon(Icons.email),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: BlocConsumer<InsertMemberCubit, InsertMemberState>(
                  listener: (context, state) {
                    if (state is InsertMemberLoading) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User Added Successfully !"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is InsertMemberLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GFButton(
                      onPressed: () {
                        checkAndAddMember(context);
                      },
                      text: "Add Member",
                      icon: Icon(Icons.person_add),
                      fullWidthButton: true,
                      shape: GFButtonShape.pills,
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  checkAndAddMember(BuildContext context) {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name Cant be Empty"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Phone Cant be Empty"),
        ),
      );
      return;
    }
    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Address Cant be Empty"),
        ),
      );
      return;
    }
    context.read<InsertMemberCubit>().insertToDatabase(
          name: _nameController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          email: _emailController.text,
          payId: _selectedLevel,
          startDate: _dateTime,
          endDate: _upToDate,
        );
  }
}

class AddMemberTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefixIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(),
          hintText: hintText,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  const AddMemberTextField({
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
  });
}
