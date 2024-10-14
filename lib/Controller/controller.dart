import 'dart:io';

import 'package:adwance_ui/ChatHelper/Chat_helper.dart';
import 'package:adwance_ui/modal_class/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtChat = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  DateTime selectDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  //  Rx<DateTime> selectDate = DateTime.now().obs ;
  // // late Rx<DateTime?> selectDate;
  //   Rx<TimeOfDay> selectedTime =TimeOfDay.now().obs;
  Rx<File>? ImgPath;
  Rx<File>? ImgPath1;
  RxString dummyImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU_7xOzl2JQiuJ7lMmrUc4HL0eCahsolVATw&s'
          .obs;

  // DatabaseHelper databaseHelper = DatabaseHelper();



  RxList DataList = [].obs;

  @override
  void onInit() {
    super.onInit();
    initDb();
    getRecords();
  }

  Future insertRecord(String name, String phone, String chat, String img,
      String Time, String Time2) async {
    await DbHelper.dbHelper.insertData(
        Name: name,
        Phone: phone,
        Chat: chat,
        img: img,
        Time: Time,
        Time2: Time2);
    await getRecords();
  }


  Future initDb() async {
    await DbHelper.dbHelper.database;
    await getRecords();
  }

  void getImg(File img) {
    ImgPath = img.obs;
  }
  void getImg1(File img) {
    ImgPath1 = img.obs;
  }

  Future getRecords() async {
    DataList.value = await DbHelper.dbHelper.readData();

    return DataList;
  }

  Future<void> removeRecords(int id) async {
    await DbHelper.dbHelper.deleteData(id);
    await getRecords();
  }

  void updateRecords(int id, String name, String phone, String chat, String img,String Time, String Time2) async {
    {
      await DbHelper.dbHelper
          .updateData(id, name, phone, chat, img,Time,Time2);
      await getRecords();
    }
  }


}



