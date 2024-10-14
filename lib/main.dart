import 'package:adwance_ui/Screens/Day%201/Home_Page.dart';
import 'package:adwance_ui/Screens/Day%201/Home_Page1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

Color color1 = Color(0xffe5ebdd);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   datePickerTheme: DatePickerThemeData(
        //     backgroundColor: Color(0xffe5ebdd),
        //     // dayBackgroundColor: WidgetStatePropertyAll(Colors.green),
        //     // dayForegroundColor: WidgetStatePropertyAll(Color(0xffe5ebdd),),
        //     dayOverlayColor: WidgetStatePropertyAll(Colors.green,),
        //     todayBackgroundColor: WidgetStatePropertyAll(Colors.green),
        //     headerBackgroundColor: Colors.green,
        //     headerForegroundColor: Colors.green,
        //     rangePickerSurfaceTintColor: Colors.green,
        //     shadowColor: Colors.green,
        //
        //     // rangePickerShape: OutlineInputBorder(),
        //     surfaceTintColor: Colors.green,
        //     // todayForegroundColor:  WidgetStatePropertyAll(Colors.green),
        //     yearForegroundColor:  WidgetStatePropertyAll(Colors.green),
        //     yearBackgroundColor:  WidgetStatePropertyAll(Colors.green),
        //     confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.green)),
        //     rangePickerBackgroundColor: Colors.green,
        //     inputDecorationTheme: InputDecorationTheme( ),
        //     rangePickerHeaderBackgroundColor: Colors.green,
        //     rangePickerHeaderForegroundColor: Colors.green,
        //     rangePickerShadowColor: Colors.green,
        //     yearOverlayColor: WidgetStatePropertyAll(Color(0xffe5ebdd),),
        //     rangeSelectionOverlayColor: WidgetStatePropertyAll(Color(0xffe5ebdd),),
        //     rangeSelectionBackgroundColor: Colors.green,
        //     cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.green)),
        //   )
        home: (!data.value) ? HomePage() : HomePage1(),
        // theme: ThemeData(colorScheme: ColorScheme.dark()),
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(
            onPrimary: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            onPrimary: Colors.white,

          )
        ),
        themeMode: (!theme1.value)?ThemeMode.light:ThemeMode.dark,


      ),
    );
  }
}
