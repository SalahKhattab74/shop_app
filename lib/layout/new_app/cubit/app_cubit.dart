import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/new_app/cubit/app_states.dart';
import 'package:shop_app/network/local/cahce_helper.dart';

import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  // Database database;
  // List<Map> newTasks = [];
  // List<Map> doneTasks = [];
  // List<Map> archivedTasks = [];
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    // NewTasksScreen(),
    // DoneTasksScreen(),
    // ArchivedTasksScreen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  //
  // void createDatabase() {
  //   openDatabase(
  //     'todo.db',
  //     version: 1,
  //     onCreate: (database, version) {
  //       print('database Created');
  //       database
  //           .execute(
  //           'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT , time TEXT, status TEXT)')
  //           .then((value) {
  //         print('table created');
  //       }).catchError((error) {
  //         print('Error When Creating Table ${error.toString()}');
  //       });
  //     },
  //     onOpen: (database) {
  //       getDataFromDatabase(database);
  //       print('database Opened');
  //     },
  //   ).then((value) => {
  //     database = value,
  //     emit(AppCreateDatabaseState()),
  //   });
  // }
  //
  // insertToDatabase(
  //     {required String title,
  //       required String time,
  //       required String date}) async {
  //   await database.transaction((txn) {
  //     txn
  //         .rawInsert(
  //         'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
  //         .then((value) => {
  //       print('$value Inserted Successfully'),
  //       emit(AppInsertDatabaseState()),
  //       getDataFromDatabase(database),
  //     })
  //         .catchError((error) {
  //       print('Error When Inserting Record ${error.toString()}');
  //     });
  //     return null;
  //   });
  // }
  //
  // void getDataFromDatabase(database) {
  //   newTasks = [];
  //   doneTasks = [];
  //   archivedTasks = [];
  //   emit(AppGetDatabaseLoadingState());
  //   database.rawQuery('SELECT * FROM tasks').then((value) => {
  //     value.forEach((element) {
  //       if (element['status'] == 'new')
  //         newTasks.add(element);
  //       else if (element['status'] == 'done')
  //         doneTasks.add(element);
  //       else
  //         archivedTasks.add(element);
  //     }),
  //     emit(AppGetDatabaseState()),
  //   });
  // }
  //
  // void updateData({required String status, required int id}) async {
  //   database.rawUpdate('UPDATE tasks SET status = ? WHERE id =?', [
  //     '$status',
  //     '$id'
  //   ]).then((value) => {
  //     getDataFromDatabase(database),
  //     emit(AppUpdateDatabaseState()),
  //   });
  // }
  //
  // void deleteData({@required int id}) async {
  //   database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) => {
  //     getDataFromDatabase(database),
  //     emit(AppDeleteDatabaseState()),
  //   });
  // }

  bool isButtonSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState(
      {@required bool isShow, @required IconData icon}) {
    isButtonSheetShown = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }
  bool isDark = false;

  // void changeAppMode({required bool fromShared})
  // {
  //   // ignore: unnecessary_null_comparison
  //   if(fromShared!=null)
  //     {
  //       isDark = fromShared;
  //       emit(AppChangeModeState());
  //   }
  //   else
  //     {
  //       isDark = !isDark;
  //       CacheHelper.putBoolean(key : 'isDark', value: isDark).then((value) => {
  //         emit(AppChangeModeState()),
  //       });
  //     }
  // }
void changeAppMode({bool fromShared}){
  if(fromShared != null)
    {
      isDark = fromShared;

      emit(AppChangeModeState());
  }
  else {
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) => {
      emit(AppChangeModeState()),
    });
  }

}
}
