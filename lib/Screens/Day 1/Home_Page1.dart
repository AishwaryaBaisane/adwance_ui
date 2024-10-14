import 'dart:io';
import 'package:adwance_ui/Controller/controller.dart';
import 'package:adwance_ui/Screens/Day%201/Home_Page.dart';
import 'package:adwance_ui/Utils/global.dart';
import 'package:adwance_ui/main.dart';
import 'package:adwance_ui/modal_class/modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ChatModal chatModal = Get.put(ChatModal());
    ChatController chatController = Get.put(ChatController());
    return SafeArea(
      child: DefaultTabController(
          length: 4,
          child: CupertinoTabScaffold(
            // restorationId: ,
            tabBar: CupertinoTabBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_2), label: "Chat"),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.phone),
                  label: 'Call',
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings), label: "Setting")
              ],
            ),
            tabBuilder: (context, index) {
              return CupertinoTabView(
                builder: (BuildContext context) {
                  switch (index) {
                    case 0:
                      return ColumnWidget();
                      break;
                    case 1:
                      return ColumnWidget2();
                      break;
                    case 2:
                      return ColumnWidget3();
                      break;
                    case 3:
                      return ColumnWidget4();
                      break;
                    default:
                      return Container();
                  }
                },
              );
            },
          )),
    );
  }
}
