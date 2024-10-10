import 'dart:io';

import 'package:adwance_ui/Controller/controller.dart';
import 'package:adwance_ui/main.dart';
import 'package:adwance_ui/modal_class/modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

ImagePicker imagePicker = ImagePicker();
File? fileImage;


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ChatModal chatModal = Get.put(ChatModal());
    ChatController chatController = Get.put(ChatController());
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Obx(() => Scaffold(
          appBar: AppBar(
            title: const Text('Platform Convertor '),
            actions: [
              Switch(
                value: false,
                onChanged: (value) {
                  value = !value;
                },
              )
            ],
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'CALLS',
              ),
              Tab(
                text: 'SETTING',
              ),
            ]),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.07,
                  ),
                   GestureDetector(
                     onTap: () async {
                       XFile? imagePath = await imagePicker.pickImage(
                           source: ImageSource.gallery);
                         fileImage = File(imagePath!.path);

                     },
                     child: CircleAvatar(
                      radius: 70,
                                       ),
                   ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  buildTextField(
                      icon: Icons.person,
                      text: 'Full Name',
                      Controler: chatController.txtName),
                  buildTextField(
                      icon: Icons.phone,
                      text: 'Phone Number',
                      Controler: chatController.txtPhone),
                  buildTextField(
                      icon: Icons.chat,
                      text: 'Chat Conversion',
                      Controler: chatController.txtChat),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () async {
                            chatController.selectDate = await showDatePicker(
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
                                        foregroundColor: const Color(
                                            0xff386927), // button text color
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
                          },
                          child: const Icon(
                            Icons.calendar_today,
                          )),
                      Text(
                        (chatController.selectDate == null)
                            ? '  ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
                            : '  ${chatController.selectDate!.day}/${chatController.selectDate!.month}/${chatController.selectDate!.year}',
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
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
                          child: const Icon(
                            Icons.watch_later_outlined,
                          )),
                      Text(
                        (chatController.selectedTime == null)
                            ? '  ${DateTime.now().hour}:${DateTime.now().minute}'
                            : '  ${chatController.selectedTime!.hour}:${chatController.selectedTime!.minute}',
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        String d1 = chatController.txtName.text;
                        String d2 = chatController.txtPhone.text;
                        String d3 = chatController.txtChat.text;
                        chatController.insertRecord(
                            d1,d2,d3);
                      },
                      child: const Text('Save'))
                ],
              ),
            ),
            // Column(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: TextField(
            //         cursorColor: Colors.white,
            //         decoration: InputDecoration(
            //           // labelText: 'Date',
            //           // labelStyle: TextStyle(color: Colors.green),
            //           semanticCounterText: 'hiiii',
            //           helperText: 'MM/DD/YYYY',
            //           helperStyle:
            //               TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            //           focusedBorder: OutlineInputBorder(
            //               borderSide:
            //                   BorderSide(color: Color(0xff386927), width: 2),
            //               borderRadius: BorderRadius.circular(10)),
            //           border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(15)),
            //           hintText: (selectDate == null)
            //               ? '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
            //               : '${selectDate!.day}/${selectDate!.month}/${selectDate!.year}',
            //           suffixIcon: InkWell(
            //               onLongPress: () {
            //                 Future<TimeOfDay?> selectedTime = showTimePicker(
            //                   builder: (context, child) {
            //                     return Theme(
            //                         data: Theme.of(context).copyWith(
            //                             colorScheme: ColorScheme.light(
            //                                 primary: Color(0xff386927),
            //                                 onSurface: Colors.black,
            //                                 primaryContainer: Colors.green,
            //                                 surface: color1)),
            //                         child: child!);
            //                   },
            //                   initialTime: TimeOfDay.now(),
            //                   context: context,
            //                 );
            //               },
            //               onTap: () async {
            //                 selectDate = await showDatePicker(
            //                   builder: (context, child) {
            //                     return Theme(
            //                       data: Theme.of(context).copyWith(
            //                         colorScheme: ColorScheme.light(
            //                             primary: Color(0xff386927),
            //                             onSurface: Colors.black,
            //                             primaryContainer: Colors.black,
            //                             surface: color1),
            //                         textButtonTheme: TextButtonThemeData(
            //                           style: TextButton.styleFrom(
            //                             foregroundColor: Color(
            //                                 0xff386927), // button text color
            //                           ),
            //                         ),
            //                       ),
            //                       child: child!,
            //                     );
            //                   },
            //                   context: context,
            //                   firstDate: DateTime(1950),
            //                   lastDate: DateTime.now(),
            //                 );
            //
            //                 setState(() {});
            //               },
            //               child: Icon(
            //                 Icons.calendar_today,
            //               )),
            //           enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Color(0xff386927),
            //                 width: 2,
            //               ),
            //               borderRadius: BorderRadius.circular(10)),
            //         ),
            //       ),
            //     ),
            //     CupertinoDialogAction(
            //       child: Text("Ringtones"),
            //       onPressed: () {
            //         showCupertinoDialog(
            //           context: context,
            //           builder: (context) => CupertinoAlertDialog(
            //             // setThemeColor: Colors.red,
            //             title: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Phone ringtone",
            //                   style: TextStyle(fontSize: 25),
            //                 ),
            //                 SizedBox(
            //                   height: 5,
            //                 ),
            //               ],
            //             ),
            //             content: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Divider(
            //                   color: Colors.black,
            //                 ),
            //                 Container(
            //                   height: 170,
            //                   child: SingleChildScrollView(
            //                     child: Column(
            //                       mainAxisSize: MainAxisSize.min,
            //                       children: [
            //                         RadioMenuButton(
            //                             value: true,
            //                             groupValue: false,
            //                             onChanged: (value) {},
            //                             child: Text("None")),
            //                         RadioMenuButton(
            //                           value: true,
            //                           groupValue: true,
            //                           onChanged: (value) {},
            //                           child: Text("Callisto"),
            //                         ),
            //                         RadioMenuButton(
            //                             value: true,
            //                             groupValue: false,
            //                             onChanged: (value) {},
            //                             child: Text("Ganymede")),
            //                         RadioMenuButton(
            //                             value: true,
            //                             groupValue: false,
            //                             onChanged: (value) {},
            //                             child: Text("Luna")),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //                 Divider(
            //                   color: Colors.black,
            //                 ),
            //                 Row(
            //                   // mainAxisSize: MainAxisSize.min,
            //                   mainAxisAlignment: MainAxisAlignment.end,
            //                   children: [
            //                     TextButton(
            //                         onPressed: () {
            //                           // Get.back();
            //                         },
            //                         child: const Text(
            //                           "Cancel",
            //                           style:
            //                               TextStyle(color: Color(0xffAC3817)),
            //                         )),
            //                     TextButton(
            //                         onPressed: () {
            //                           // Get.back();
            //                         },
            //                         child: const Text(
            //                           "OK",
            //                           style:
            //                               TextStyle(color: Color(0xffAC3817)),
            //                         )),
            //                   ],
            //                 )
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //       isDestructiveAction: true,
            //     ),
            //     SizedBox(
            //       height: 250,
            //       child: CupertinoDatePicker(
            //         onDateTimeChanged: (value) {},
            //       ),
            //     ),
            //   ],
            // ),
            ListView.builder(
                itemBuilder: (context, index) => Card(
                  child:
                  Text(chatController.DataList[index]['Name'].toString()),
                ),
                itemCount: chatController.DataList.length),
            Text('hello Flutter'),
            Text('hello Flutter'),
          ]),



          // floatingActionButton: Row(
          //   children: [
          //     FloatingActionButton(
          //       onPressed: () {
          //         showModalBottomSheet(
          //           context: context,
          //           builder: (context) {
          //             return Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 CupertinoTimerPicker(
          //                   onTimerDurationChanged: (value) {},
          //                 ),
          //               ],
          //             );
          //           },
          //         );
          //       },
          //       child: Icon(Icons.lock_clock),
          //     ),
          //     FloatingActionButton(
          //       onPressed: () {
          //         showCupertinoModalPopup<void>(
          //           context: context,
          //           builder: (BuildContext context) => CupertinoActionSheet(
          //             title: const Text('Favorite Dessert'),
          //             message: const Text(
          //                 '\n\n Pleas Select the best Dessert From the \n Option below.'),
          //             actions: <CupertinoActionSheetAction>[
          //               CupertinoActionSheetAction(
          //                 isDefaultAction: true,
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Text('Profiteroles'),
          //               ),
          //               CupertinoActionSheetAction(
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Text('Cannolis'),
          //               ),
          //               CupertinoActionSheetAction(
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Text('Trifle'),
          //               ),
          //               CupertinoActionSheetAction(
          //                 isDestructiveAction: true,
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Text('Cancel'),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //       child: Icon(Icons.lock_clock),
          //     ),
          //   ],
          // )),
        ),)
      ),
    );
  }
}

Widget buildTextField(
    {required IconData icon,
    required String text,
    required TextEditingController Controler}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextField(
      controller: Controler,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Row(
          children: [
            Icon(icon),
            Text('  $text'),
          ],
        ),
      ),
    ),
  );
}
