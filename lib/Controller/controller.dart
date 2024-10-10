import 'package:adwance_ui/ChatHelper/Chat_helper.dart';
import 'package:adwance_ui/modal_class/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ChatController extends GetxController
{

  TextEditingController txtName =  TextEditingController();
  TextEditingController txtPhone =  TextEditingController();
  TextEditingController txtChat =  TextEditingController();
  DateTime? selectDate;
  DateTime? selectedTime;
  // DatabaseHelper databaseHelper = DatabaseHelper();

  RxList DataList = [].obs;

  @override
  void onInit() {
    super.onInit();
    initDb();
  }

  Future insertRecord(String name, String phone,String chat) async {
    await DbHelper.dbHelper.insertData(Name: name, Phone: phone, Chat: chat);
    await getRecords();
  }

  Future initDb() async {
    await DbHelper.dbHelper.database;
    await getRecords();
  }

  Future getRecords() async {

    DataList.value = await DbHelper.dbHelper.readData();

    return DataList;
  }


}