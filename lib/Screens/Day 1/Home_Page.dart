import 'package:adwance_ui/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  // labelText: 'Date',
                  // labelStyle: TextStyle(color: Colors.green),
                  semanticCounterText: 'hiiii',
                  helperText: 'MM/DD/YYYY',
                  helperStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff386927), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: (selectDate == null)
                      ? '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
                      : '${selectDate!.day}/${selectDate!.month}/${selectDate!.year}',
                  suffixIcon: InkWell(
                      onLongPress: () {
                        Future<TimeOfDay?> selectedTime = showTimePicker(
                          builder: (context, child) {
                            return Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                        primary: Color(0xff386927),
                                        onSurface: Colors.black,
                                        primaryContainer: Colors.green,
                                        surface: color1)),
                                child: child!);
                          },
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                      },
                      onTap: () async {
                        selectDate = await showDatePicker(
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                    primary: Color(0xff386927),
                                    onSurface: Colors.black,
                                    primaryContainer: Colors.black,
                                    surface: color1),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Color(0xff386927), // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );

                        setState(() {});
                      },
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff386927),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            CupertinoDialogAction(
              child: Text("Ringtones"),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    // setThemeColor: Colors.red,
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone ringtone",
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          color: Colors.black,
                        ),
                        Container(
                          height: 170,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RadioMenuButton(
                                    value: true,
                                    groupValue: false,
                                    onChanged: (value) {},
                                    child: Text("None")),
                                RadioMenuButton(
                                  value: true,
                                  groupValue: true,
                                  onChanged: (value) {},
                                  child: Text("Callisto"),
                                ),
                                RadioMenuButton(
                                    value: true,
                                    groupValue: false,
                                    onChanged: (value) {},
                                    child: Text("Ganymede")),
                                RadioMenuButton(
                                    value: true,
                                    groupValue: false,
                                    onChanged: (value) {},
                                    child: Text("Luna")),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  // Get.back();
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Color(0xffAC3817)),
                                )),
                            TextButton(
                                onPressed: () {
                                  // Get.back();
                                },
                                child: const Text(
                                  "OK",
                                  style: TextStyle(color: Color(0xffAC3817)),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              isDestructiveAction: true,
            ),
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {},
              ),
            ),
          ],
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(onPressed: () {
              showModalBottomSheet(context: context, builder:(context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoTimerPicker(onTimerDurationChanged: (value) {

                    },),
                  ],
                );
              },);
            },child: Icon(Icons.lock_clock),),
            FloatingActionButton(onPressed: () {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: const Text('Favorite Dessert'),
                  message: const Text('\n\n Pleas Select the best Dessert From the \n Option below.'),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(

                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Profiteroles'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cannolis'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Trifle'),
                    ),
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );

            },child: Icon(Icons.lock_clock),),
          ],
        )
      ),
    );
  }
}

DateTime? selectDate;
