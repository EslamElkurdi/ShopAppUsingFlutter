
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/modules/todo_app/archived_tasks/archived_task.dart';
import 'package:loginscreen/modules/todo_app/done_tasks/done_task.dart';
import 'package:loginscreen/modules/todo_app/new_tasks/new_task.dart';
import 'package:loginscreen/shared/components/constants.dart';
import 'package:loginscreen/shared/cubit/app_states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialAppState());

  int currentIndex = 0;
  late Database database;
  IconData fabIcon = Icons.add;
  bool isBottomSheet = false;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screens =
  [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks()
  ];

  List<Map> tasks = [];

  List<String> appBarText =
  [
    "New Task",
    "Done Task",
    "Archived Task"
  ];

  static AppCubit get(context) => BlocProvider.of(context);

  void changeBottomCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  void changeFabIconAndBottomSheet({
  required bool isShow,
    required IconData icon,
}){
    fabIcon = icon;
    isBottomSheet = isShow;

    emit(ChangeFabAndBottomSheet());
  }

  void createDB()
  {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version ) async
        {

          print("Database is created");
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT, status TEXT)'
          ).then((value)
          {
            print('Tables are created');
          }).catchError((error){
            print('catch error ${error.toString()}');
          });
        },
        onOpen: (database) async
        {
          emit(AppGetLoading());

          getDataFromDatabase(database);
          print('Database is opened');


        }
    ).then((value){
        database = value;
        emit(CreateDBState());
    });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
     await database.transaction((txn) async
    {
      txn.rawInsert(
          'INSERT INTO tasks(title, data, time, status) VALUES("$title","$date", "$time", "new")'
      ).then((value)
      {
        print("Inserted Success");
        emit(InsertToDBState());

        getDataFromDatabase(database);


      }).catchError((error)
      {
        print("happened Error ${error.toString()}");
      });
    });
  }

  void getDataFromDatabase(database)
  {
    newTasks = [];
    archivedTasks = [];
    doneTasks = [];

    emit( AppGetLoading());
    database.rawQuery('SELECT * FROM tasks').then((value){
      tasks = value;

      tasks.forEach((element) {
          print(element['status']);
          if(element['status'] == 'done')
            doneTasks.add(element);
          else if(element['status'] == 'new')
            newTasks.add(element);
          else
            archivedTasks.add(element);
      });
      emit(GetDBState());
    });
  }

  void deleteDB({
    required int id
  }) async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getDataFromDatabase(database);
      emit(DeleteDataBase());
    });
  }

  void UpdateDB({
  required String status,
    required int id
}) async
  {
  database.rawUpdate(
  'UPDATE tasks SET status = ? WHERE id = ?',
  ['$status', id],).then((value){

    getDataFromDatabase(database);
    emit(UpdateDataBase());
  });
  }
}