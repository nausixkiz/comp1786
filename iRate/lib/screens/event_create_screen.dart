import 'package:flutter/material.dart';
import 'package:irate/widgets/custom/custom_date_picker_text_field.dart';
import 'package:irate/widgets/custom/custom_text_field.dart';
import 'package:irate/widgets/custom/custom_time_picker_text_field.dart';
import 'package:irate/widgets/error_dialog.dart';

class EventCreateScreen extends StatefulWidget {
  const EventCreateScreen({Key? key}) : super(key: key);

  @override
  State<EventCreateScreen> createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController activityNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateHeldController = TextEditingController();
  TextEditingController timeOfAttendingController = TextEditingController();
  TextEditingController nameOfReporterController = TextEditingController();
  TextEditingController reportController = TextEditingController();

  clearAllInput() {
    setState(() {
      activityNameController.clear();
      locationController.clear();
      dateHeldController.clear();
      timeOfAttendingController.clear();
      nameOfReporterController.clear();
      reportController.clear();
    });
  }

  Future<void> formValidation() async {
    if (activityNameController.text.isNotEmpty &&
        dateHeldController.text.isNotEmpty &&
        nameOfReporterController.text.isNotEmpty) {
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return ErrorDialog(
            message: "Please fill in all the required fields",
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.deepOrange,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )),
          ),
          title: const Text("Create New Event",
              style: TextStyle(fontSize: 20, fontFamily: "Lobster")),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              clearAllInput();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          actions: [
            TextButton(
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
                onPressed: () {
                  formValidation();
                }),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            iconData: Icons.celebration,
                            controller: activityNameController,
                            text: "Activity Name",
                            isObscure: false,
                            isEnabled: true),
                        CustomTextField(
                            iconData: Icons.add_location,
                            controller: locationController,
                            text: "Location",
                            isObscure: false,
                            isEnabled: true),
                        CustomDatePickerTextField(
                            iconData: Icons.calendar_today,
                            controller: dateHeldController,
                            text: "Date Held"),
                        CustomTimePickerTextField(
                            iconData: Icons.access_time,
                            controller: timeOfAttendingController,
                            text: "Time Of Attending"),
                        CustomTextField(
                          iconData: Icons.account_circle,
                          controller: nameOfReporterController,
                          text: "Name Of Reporter",
                            isObscure: false,
                            isEnabled: true),
                        CustomTextField(
                            iconData: Icons.edit_note,
                            controller: reportController,
                            text: "Report",
                            isObscure: false,
                            isEnabled: true),
                      ],
                    )),
              ],
            )));
  }
}
