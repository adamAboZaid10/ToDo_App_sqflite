import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodoapp/controller/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialTodoStates());
  //this object of use easy
  static TodoCubit get(context) => BlocProvider.of(context);

  Database? database;

  // create
  void createDataBase() {
    openDatabase('taskss.db', version: 1, onCreate: (database, version) {
      print("DataBase Created");
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT ,date TEXT,time TEXT ,description TEXT,status TEXT)')
          .then((value) {
        print('table Created');
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (database) {
      print('DataBase file is opened ');
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(CreateToDoDatabaseState());
    }).catchError((error) {
      print('error when opening the file');
    });
  }

  //insert
  void insertInToDataBase({
    required title,
    required date,
    required time,
    required description,
    String status = "new",
  }) {
    database!.transaction((txn) async {
      txn
          .rawInsert('INSERT INTO tasks'
              '(title , date, time, description, status) VALUES'
              '("$title" , "$date" , "$time","$description","$status")')
          .then((value) {
        print('$value inserted successfully');
        getDataFromDatabase(database);
        emit(InertIntoToDoDatabaseState());
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  //get
  List tasks = [];
  void getDataFromDatabase(database) {
    emit(LoadingGetDataFromToDoDatabaseState());
    tasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        tasks.add(element);
      });
      print('data get');
      print(value);
      emit(GetDataFromToDoDatabaseState());
    }).catchError((error) {
      print('error when get data from dataBase');
    });
  }

  //update
  void updateDataIntoDatabase({
    required String title,
    required String date,
    required String time,
    required String description,
    required int id,
  }) {
    database!
        .update(
            'tasks',
            {
              "title": title,
              "date": date,
              "time": time,
              "description": description,
            },
            where: 'id =?',
            whereArgs: [id])
        .then((value) {
      print('update data is successfully ');
      emit(UpdatingDataFromDatabaseState());
      getDataFromDatabase(database);
    }).catchError((error) {
      print(error.toString());
    });
  }

  //delete
  void deleteDataFromDataBase({required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      print('deleted Successfully');
      getDataFromDatabase(database);
    }).catchError((error) {
      print(error.toString());
    });
  }

  void changeLanguageToArabic(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('en', 'US')) {
      context.locale = const Locale('ar', 'EG');
    }
    emit(ChangeLanguageToArabicState());
  }

  void changeLanguageToEnglish(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('ar', 'EG')) {
      context.locale = const Locale('en', 'US');
    }
    emit(ChangeLanguageToEnglishState());
  }
}
