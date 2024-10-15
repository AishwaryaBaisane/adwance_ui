# adwance_ui
<p>
  <img src = "https://github.com/user-attachments/assets/299f276a-c7bd-4888-bdce-0f409ff9dc8a" height = 25% width = 30%>
  <img src = "https://github.com/user-attachments/assets/e2b842d7-17bc-4ec4-8537-bd44970da341" height = 25% width = 30%>
  <img src = "https://github.com/user-attachments/assets/fe2cd613-c8f1-4105-8369-a30cd24e1744" height = 25% width = 30%>
  <img src = "https://github.com/user-attachments/assets/2f228726-c868-472e-8498-443cf6a20ac0" height = 25% width = 30%>
  <img src = "https://github.com/user-attachments/assets/6e9130be-9efa-43d9-99fb-1b415b022ef4" height = 25% width = 30%>
  <img src = "https://github.com/user-attachments/assets/2922b33b-5800-4788-aaab-9b6ceb538e53" height = 25% width = 30%>
  <img src = "https://github.com/user-attachments/assets/d85d7840-f07d-408c-9360-8d0bfaab66e6" height = 25% width = 30%>
  <img src = "https://github.com/user-attachments/assets/ca736e3a-9c2f-4fc2-a0e5-e80d8be7a7a0" height = 25% width = 30%>

</p>


## platform converter :

### Creating a platform converter app using Flutter with a Cupertino design and database integration is a great way to ensure a native iOS feel while maintaining cross-platform functionality. Here's how to do it step by step:

- 1. Set Up Flutter Environment
Make sure you have Flutter installed and set up. Create a new Flutter project:

- 2. Add Dependencies
Update your pubspec.yaml file to include the necessary dependencies for SQLite:

```dart
yaml
Copy code
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  sqflite: ^2.0.0+3
  path: ^1.8.0
```
- 3. Create the UI with Cupertino Widgets
Use Cupertino widgets to build the user interface. Here's a simple implementation of the main screen:

```dart
Copy code
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Platform Converter',
      home: ConverterScreen(),
    );
  }
}
```

- 4. Implement Database Logic
Set up SQLite to store conversion history or user preferences. Here’s a basic example of how to implement the database helper:

```dart
Copy code
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'converter.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE conversions(id INTEGER PRIMARY KEY, value REAL, unit TEXT)",
      );
    });
  }

  Future<void> insertConversion(double value, String unit) async {
    final db = await database;
    await db.insert('conversions', {'value': value, 'unit': unit});
  }

  Future<List<Map<String, dynamic>>> getConversions() async {
    final db = await database;
    return await db.query('conversions');
  }
}
```
<p>
    <img src = "https://github.com/user-attachments/assets/a6f5c597-ce2a-403c-9b70-bfe6e116d899" height = 25% width = 30%>
    <img src = "https://github.com/user-attachments/assets/a02ef982-1e8f-4b41-b590-c9e66b619afd" height = 25% width = 30%> 
    <img src = "https://github.com/user-attachments/assets/9215c16a-d751-4d81-a85e-40f6e4c07d32" height = 25% width = 30%>  
    <img src = "https://github.com/user-attachments/assets/c82d43e1-8fc0-4e42-9d60-4937b96cba53" height = 25% width = 30%>  
    <img src = "https://github.com/user-attachments/assets/593ba3ba-2bfe-44e1-a3e8-b2208bc40bcd" height = 25% width = 30%>
    <img src = "https://github.com/user-attachments/assets/1addd261-dbf6-454c-85e1-48bf0e10a6ff" height = 25% width = 30%>
    <img src = "https://github.com/user-attachments/assets/d6ed0921-53f1-42d9-9a09-502798ad2717" height = 25% width = 30%>
    <img src = "https://github.com/user-attachments/assets/3bf2d3f6-dfa0-4c57-ae22-3762ac48b7ba" height = 25% width = 30%>

</p>


https://github.com/user-attachments/assets/3473972e-90ed-4a7c-a38e-55a584e6cb0b


