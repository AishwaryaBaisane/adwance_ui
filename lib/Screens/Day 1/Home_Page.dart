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
    // ChatModal chatModal = Get.put(ChatModal());
    ChatController chatController = Get.put(ChatController());
    return SafeArea(
        child: DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Platform Convertor ',style: TextStyle(fontWeight: FontWeight.w700),),
              actions: [
                Obx(
                  () => Switch(
                    // onFocusChange: v,
                    value: data.value,
                    onChanged: (value) {
                      data.value = !data.value;
                    },
                  ),
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
              ])),
          // backgroundColor: Colors.white,
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
                        ImagePicker imagePicker = ImagePicker();
                        XFile? xFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        String path = xFile!.path;
                        File fileImage = File(path);
                        chatController.getImg(fileImage);
                      },
                      child: Obx(
                        () => CircleAvatar(
                          radius: 70,
                          backgroundImage: (chatController.ImgPath != null)
                              ? FileImage(chatController.ImgPath!.value)
                              : NetworkImage(chatController.dummyImage.value),
                        ),
                      )),
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
                            chatController.selectDate = (await showDatePicker(
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
                            ))!;
                          },
                          child: Padding(
                            padding: const  EdgeInsets.only(right: 10),
                            child: const Icon(
                              Icons.calendar_today,
                            ),
                          )),
                      Text('Date Pick')
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          chatController.selectedTime = (await showTimePicker(
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
                          ))!;
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.watch_later_outlined,
                          ),
                        ),
                      ),
                      Text('Time Pick'),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        String d1 = chatController.txtName.text;
                        String d2 = chatController.txtPhone.text;
                        String d3 = chatController.txtChat.text;
                        String time = chatController.selectDate.toString();
                        String time2 = chatController.selectedTime.toString();
                        chatController.insertRecord(d1, d2, d3,
                            chatController.ImgPath!.value.path, time, time2);
                        print(chatController.ImgPath!.value.path);

                        chatController.txtName.clear();
                        chatController.txtPhone.clear();
                        chatController.txtChat.clear();
                        // controller.txtAmount.clear();
                        // controller.txtCategory.clear();
                      },
                      child: const Text('Save'))
                ],
              ),
            ),
            Obx(
              () => ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                        onLongPress: () {
                          chatController.removeRecords(
                            int.parse(
                              chatController.DataList[index]['id'].toString(),
                            ),
                          );
                          // chatController.DataList[index]['id'];
                        },

                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                "Update your record",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () async {
                                          ImagePicker imagePicker =
                                              ImagePicker();
                                          XFile? xFile =
                                              await imagePicker.pickImage(
                                                  source: ImageSource.gallery);
                                          String path = xFile!.path;
                                          File fileImage = File(path);
                                          chatController.getImg(fileImage);
                                        },
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: FileImage(
                                            File(
                                              chatController.DataList[index]
                                                  ['img'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      cursorColor: Colors.grey,
                                      controller: chatController.txtName,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: chatController.DataList[index]
                                                ['Name']
                                            .toString(),
                                        labelStyle: const TextStyle(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      cursorColor: Colors.grey,
                                      controller: chatController.txtPhone,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: chatController.DataList[index]
                                                ['Phone']
                                            .toString(),
                                        labelStyle: const TextStyle(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      cursorColor: Colors.grey,
                                      controller: chatController.txtChat,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: chatController.DataList[index]
                                                ['Chat']
                                            .toString(),
                                        labelStyle: const TextStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              // chatController.selectDate = data.toString();
                                              chatController.selectDate =
                                                  (await showDatePicker(
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          ColorScheme.light(
                                                              primary: Color(
                                                                  0xff386927),
                                                              onSurface:
                                                                  Colors.black,
                                                              primaryContainer:
                                                                  Colors.black,
                                                              surface: color1),
                                                      textButtonTheme:
                                                          TextButtonThemeData(
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              const Color(
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
                                              ))!;
                                              // String hi = data.toString();
                                              // chatController.selectDate =
                                              //     hi;
                                            },
                                            child: const Icon(
                                              Icons.calendar_today,
                                            )),
                                        Text(
                                          '  ${chatController.selectDate.day}/${chatController.selectDate.month}/${chatController.selectDate.year}',
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              chatController.selectedTime =
                                                  (await showTimePicker(
                                                builder: (context, child) {
                                                  return Theme(
                                                      data: Theme.of(context).copyWith(
                                                          colorScheme: ColorScheme.light(
                                                              primary:
                                                                  const Color(
                                                                      0xff386927),
                                                              onSurface:
                                                                  Colors.black,
                                                              primaryContainer:
                                                                  Colors.green,
                                                              surface: color1)),
                                                      child: child!);
                                                },
                                                initialTime: TimeOfDay.now(),
                                                context: context,
                                              ))!;
                                            },
                                            child: const Icon(
                                              Icons.watch_later_outlined,
                                            )),
                                        Text(
                                          '  ${chatController.selectedTime.hour}:${chatController.selectedTime.minute}',
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // txtController.clear();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    String time =
                                        chatController.selectDate.toString();
                                    String time2 =
                                        chatController.selectedTime.toString();
                                    chatController.updateRecords(
                                      chatController.DataList[index]['id'],
                                      chatController.txtName.text,
                                      chatController.txtChat.text,
                                      chatController.txtPhone.text,
                                      chatController.ImgPath!.value.path,
                                      time,
                                      time2,
                                    );

                                    print('${chatController.txtName.text} ');

                                    chatController.txtName.clear();
                                    chatController.txtPhone.clear();
                                    chatController.txtChat.clear();
                                    // controller.txtAmount.clear();
                                    // controller.txtCategory.clear();
                                    Navigator.of(context).pop();
                                    // controller.isIncome.value = false;
                                    // txtController.clear();/
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                        leading: Obx(
                          () => CircleAvatar(
                            backgroundImage: FileImage(
                              File(
                                chatController.DataList[index]['img'],
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                            chatController.DataList[index]['Name'].toString()),
                        subtitle: Text(
                            chatController.DataList[index]['Chat'].toString()),
                        // subtitle: InkWell(
                        //     onTap: () {
                        //       chatController.removeRecords(
                        //         int.parse(
                        //           chatController.DataList[index]['id']
                        //               .toString(),
                        //         ),
                        //       );
                        //       // chatController.DataList[index]['id'];
                        //     },
                        //     child: Icon(Icons.delete)),
                        trailing: Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Container(
                              width: width * 0.175,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                chatController.DataList[index]['Time'],
                              ),
                              // child:Column(
                              //   children: [
                              //     Text(
                              //       overflow: TextOverflow.ellipsis,
                              //       chatController.DataList[index]['Time'],
                              //     ),
                              //     Text(
                              //       // overflow: TextOverflow.ellipsis,
                              //       chatController.DataList[index]['Time2'],
                              //     ),
                              //   ],
                              // )
                            ),
                            Container(
                              width: width * 0.3,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                chatController.DataList[index]['Time2'],
                              ),
                            )
                          ],
                        ),
                      ),
                  itemCount: chatController.DataList.length),
            ),
            Obx(
              () => ListView.builder(
                  itemBuilder: (context, index) => Obx(
                        () => ListTile(
                            onLongPress: () {
                              chatController.removeRecords(
                                int.parse(
                                  chatController.DataList[index]['id']
                                      .toString(),
                                ),
                              );
                              // chatController.DataList[index]['id'];
                            },
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Update your record",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(
                                          () => GestureDetector(
                                            onTap: () async {
                                              ImagePicker imagePicker =
                                                  ImagePicker();
                                              XFile? xFile =
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              String path = xFile!.path;
                                              File fileImage = File(path);
                                              chatController.getImg(fileImage);
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: FileImage(
                                                File(
                                                  chatController.DataList[index]
                                                      ['img'],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          cursorColor: Colors.grey,
                                          controller: chatController.txtName,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: chatController
                                                .DataList[index]['Name']
                                                .toString(),
                                            labelStyle: const TextStyle(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          cursorColor: Colors.grey,
                                          controller: chatController.txtPhone,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: chatController
                                                .DataList[index]['Phone']
                                                .toString(),
                                            labelStyle: const TextStyle(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          cursorColor: Colors.grey,
                                          controller: chatController.txtChat,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: chatController
                                                .DataList[index]['Chat']
                                                .toString(),
                                            labelStyle: const TextStyle(),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () async {
                                                  // chatController.selectDate = data.toString();
                                                  chatController.selectDate =
                                                      (await showDatePicker(
                                                    builder: (context, child) {
                                                      return Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                          colorScheme:
                                                              ColorScheme.light(
                                                                  primary: Color(
                                                                      0xff386927),
                                                                  onSurface:
                                                                      Colors
                                                                          .black,
                                                                  primaryContainer:
                                                                      Colors
                                                                          .black,
                                                                  surface:
                                                                      color1),
                                                          textButtonTheme:
                                                              TextButtonThemeData(
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                                  const Color(
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
                                                  ))!;
                                                  // String hi = data.toString();
                                                  // chatController.selectDate =
                                                  //     hi;
                                                },
                                                child: const Icon(
                                                  Icons.calendar_today,
                                                )),
                                            Text('Dtae Pick')
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () async {
                                                  chatController.selectedTime =
                                                      (await showTimePicker(
                                                    builder: (context, child) {
                                                      return Theme(
                                                          data: Theme.of(context).copyWith(
                                                              colorScheme: ColorScheme.light(
                                                                  primary:
                                                                      const Color(
                                                                          0xff386927),
                                                                  onSurface:
                                                                      Colors
                                                                          .black,
                                                                  primaryContainer:
                                                                      Colors
                                                                          .green,
                                                                  surface:
                                                                      color1)),
                                                          child: child!);
                                                    },
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    context: context,
                                                  ))!;
                                                },
                                                child: const Icon(
                                                  Icons.watch_later_outlined,
                                                )),
                                            Text('Pick Time')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // txtController.clear();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        String time = chatController.selectDate
                                            .toString();
                                        String time2 = chatController
                                            .selectedTime
                                            .toString();
                                        chatController.updateRecords(
                                          chatController.DataList[index]['id'],
                                          chatController.txtName.text,
                                          chatController.txtChat.text,
                                          chatController.txtPhone.text,
                                          chatController.ImgPath!.value.path,
                                          time,
                                          time2,
                                        );

                                        print(
                                            '${chatController.txtName.text} ');

                                        chatController.txtName.clear();
                                        chatController.txtPhone.clear();
                                        chatController.txtChat.clear();
                                        // controller.txtAmount.clear();
                                        // controller.txtCategory.clear();
                                        Navigator.of(context).pop();
                                        // controller.isIncome.value = false;
                                        // txtController.clear();/
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            leading: Obx(
                              () => CircleAvatar(
                                backgroundImage: FileImage(
                                  File(
                                    chatController.DataList[index]['img'],
                                  ),
                                ),
                              ),
                            ),
                            title: Text(chatController.DataList[index]['Name']
                                .toString()),
                            subtitle: Text(chatController.DataList[index]
                                    ['Chat']
                                .toString()),
                            // subtitle: InkWell(
                            //     onTap: () {
                            //       chatController.removeRecords(
                            //         int.parse(
                            //           chatController.DataList[index]['id']
                            //               .toString(),
                            //         ),
                            //       );
                            //       // chatController.DataList[index]['id'];
                            //     },
                            //     child: Icon(Icons.delete)),
                            trailing: Icon(
                              Icons.call,
                              size: 30,
                              color: Colors.green,
                            )),
                      ),
                  itemCount: chatController.DataList.length),
            ),
            Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Profile',
                      style: TextStyle(fontSize: 25),
                    ),
                    Obx(
                          () => Switch(
                        // onFocusChange: v,
                        value: pr.value,
                        onChanged: (value) {
                          pr.value = !pr.value;
                        },
                      ),
                    )
                  ],
                ),
                (pr.value)?Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        im != im;
                        ImagePicker imagePicker = ImagePicker();
                        XFile? xFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        String path = xFile!.path;
                        File fileImage = File(path);
                        // print(fileImage);
                        chatController.getImg1(fileImage);
                      },
                      child:CircleAvatar(
                        radius: 70,
                        backgroundImage: (chatController.ImgPath1 != null)
                            ? FileImage(chatController.ImgPath1!.value)
                            : NetworkImage(chatController.dummyImage.value),
                      ),),
                    SizedBox(
                      width: width * 0.5,
                      child: TextField(
                        controller: chatController.name,
                        decoration: InputDecoration(
                            helperText: 'Name',
                            hintText: (chatController.name == ' ')
                                ? 'hiii'
                                : '${chatController.name.text}'),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: TextField(
                        controller: chatController.bio,
                        decoration: InputDecoration(
                            helperText: 'Bio',
                            hintText: (chatController.bio == ' ')
                                ? 'hiii'
                                : '${chatController.bio.text}'),
                      ),
                    ),
                  ],
                ):Column(
                  children: [],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Theme',
                      style: TextStyle(fontSize: 25),
                    ),
                    Obx(
                          () => Switch(
                        // onFocusChange: v,
                        value: theme1.value,
                        onChanged: (value) {
                          theme1.value = !theme1.value;
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),)
          ])),
    ));

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

GlobalKey<FormState> formKey = GlobalKey();
//
RxBool im = false.obs;
RxBool data = false.obs;
RxBool theme1 = false.obs;
RxBool pr = false.obs;

//// Column(
//               //   children: [
//               //     Padding(
//               //       padding: EdgeInsets.all(8.0),
//               //       child: TextField(
//               //         cursorColor: Colors.white,
//               //         decoration: InputDecoration(
//               //           // labelText: 'Date',
//               //           // labelStyle: TextStyle(color: Colors.green),
//               //           semanticCounterText: 'hiiii',
//               //           helperText: 'MM/DD/YYYY',
//               //           helperStyle:
//               //               TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//               //           focusedBorder: OutlineInputBorder(
//               //               borderSide:
//               //                   BorderSide(color: Color(0xff386927), width: 2),
//               //               borderRadius: BorderRadius.circular(10)),
//               //           border: OutlineInputBorder(
//               //               borderRadius: BorderRadius.circular(15)),
//               //           hintText: (selectDate == null)
//               //               ? '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
//               //               : '${selectDate!.day}/${selectDate!.month}/${selectDate!.year}',
//               //           suffixIcon: InkWell(
//               //               onLongPress: () {
//               //                 Future<TimeOfDay?> selectedTime = showTimePicker(
//               //                   builder: (context, child) {
//               //                     return Theme(
//               //                         data: Theme.of(context).copyWith(
//               //                             colorScheme: ColorScheme.light(
//               //                                 primary: Color(0xff386927),
//               //                                 onSurface: Colors.black,
//               //                                 primaryContainer: Colors.green,
//               //                                 surface: color1)),
//               //                         child: child!);
//               //                   },
//               //                   initialTime: TimeOfDay.now(),
//               //                   context: context,
//               //                 );
//               //               },
//               //               onTap: () async {
//               //                 selectDate = await showDatePicker(
//               //                   builder: (context, child) {
//               //                     return Theme(
//               //                       data: Theme.of(context).copyWith(
//               //                         colorScheme: ColorScheme.light(
//               //                             primary: Color(0xff386927),
//               //                             onSurface: Colors.black,
//               //                             primaryContainer: Colors.black,
//               //                             surface: color1),
//               //                         textButtonTheme: TextButtonThemeData(
//               //                           style: TextButton.styleFrom(
//               //                             foregroundColor: Color(
//               //                                 0xff386927), // button text color
//               //                           ),
//               //                         ),
//               //                       ),
//               //                       child: child!,
//               //                     );
//               //                   },
//               //                   context: context,
//               //                   firstDate: DateTime(1950),
//               //                   lastDate: DateTime.now(),
//               //                 );
//               //
//               //                 setState(() {});
//               //               },
//               //               child: Icon(
//               //                 Icons.calendar_today,
//               //               )),
//               //           enabledBorder: OutlineInputBorder(
//               //               borderSide: BorderSide(
//               //                 color: Color(0xff386927),
//               //                 width: 2,
//               //               ),
//               //               borderRadius: BorderRadius.circular(10)),
//               //         ),
//               //       ),
//               //     ),
//               //     CupertinoDialogAction(
//               //       child: Text("Ringtones"),
//               //       onPressed: () {
//               //         showCupertinoDialog(
//               //           context: context,
//               //           builder: (context) => CupertinoAlertDialog(
//               //             // setThemeColor: Colors.red,
//               //             title: Column(
//               //               mainAxisSize: MainAxisSize.min,
//               //               crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: [
//               //                 Text(
//               //                   "Phone ringtone",
//               //                   style: TextStyle(fontSize: 25),
//               //                 ),
//               //                 SizedBox(
//               //                   height: 5,
//               //                 ),
//               //               ],
//               //             ),
//               //             content: Column(
//               //               mainAxisSize: MainAxisSize.min,
//               //               children: [
//               //                 Divider(
//               //                   color: Colors.black,
//               //                 ),
//               //                 Container(
//               //                   height: 170,
//               //                   child: SingleChildScrollView(
//               //                     child: Column(
//               //                       mainAxisSize: MainAxisSize.min,
//               //                       children: [
//               //                         RadioMenuButton(
//               //                             value: true,
//               //                             groupValue: false,
//               //                             onChanged: (value) {},
//               //                             child: Text("None")),
//               //                         RadioMenuButton(
//               //                           value: true,
//               //                           groupValue: true,
//               //                           onChanged: (value) {},
//               //                           child: Text("Callisto"),
//               //                         ),
//               //                         RadioMenuButton(
//               //                             value: true,
//               //                             groupValue: false,
//               //                             onChanged: (value) {},
//               //                             child: Text("Ganymede")),
//               //                         RadioMenuButton(
//               //                             value: true,
//               //                             groupValue: false,
//               //                             onChanged: (value) {},
//               //                             child: Text("Luna")),
//               //                       ],
//               //                     ),
//               //                   ),
//               //                 ),
//               //                 Divider(
//               //                   color: Colors.black,
//               //                 ),
//               //                 Row(
//               //                   // mainAxisSize: MainAxisSize.min,
//               //                   mainAxisAlignment: MainAxisAlignment.end,
//               //                   children: [
//               //                     TextButton(
//               //                         onPressed: () {
//               //                           // Get.back();
//               //                         },
//               //                         child: const Text(
//               //                           "Cancel",
//               //                           style:
//               //                               TextStyle(color: Color(0xffAC3817)),
//               //                         )),
//               //                     TextButton(
//               //                         onPressed: () {
//               //                           // Get.back();
//               //                         },
//               //                         child: const Text(
//               //                           "OK",
//               //                           style:
//               //                               TextStyle(color: Color(0xffAC3817)),
//               //                         )),
//               //                   ],
//               //                 )
//               //               ],
//               //             ),
//               //           ),
//               //         );
//               //       },
//               //       isDestructiveAction: true,
//               //     ),
//               //     SizedBox(
//               //       height: 250,
//               //       child: CupertinoDatePicker(
//               //         onDateTimeChanged: (value) {},
//               //       ),
//               //     ),
//               //   ],
//               // ),
