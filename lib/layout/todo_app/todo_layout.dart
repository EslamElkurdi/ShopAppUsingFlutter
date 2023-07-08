
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/components/constants.dart';
import 'package:loginscreen/shared/cubit/app_states.dart';
import 'package:loginscreen/shared/cubit/cubit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_intl/flutter_intl.dart';

class HomeLayout extends StatelessWidget {



  var keyScaffold = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dataController = TextEditingController();
  var statusController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state)
          {
            AppCubit cubit = BlocProvider.of(context);

            return Scaffold(
              key: keyScaffold,
              appBar: AppBar(
                title: Text(
                    cubit.appBarText[cubit.currentIndex]
                ),
              ),
              bottomNavigationBar:  BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index)
                {
                  cubit.changeBottomCurrentIndex(index);
                },
                items:
                [
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.menu
                      ),
                      label: "tasks"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.check_circle
                      ),
                      label: "done"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.archive_outlined
                      ),
                      label: "archived"
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(
                    cubit.fabIcon
                ),
                onPressed: ()
                {

                  if(cubit.isBottomSheet)
                  {
                    if(formKey.currentState!.validate())
                    {

                      cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dataController.text,
                      );
                    }

                  }else{
                    keyScaffold.currentState!.showBottomSheet(

                            (context) => Container(
                          padding: const EdgeInsets.all(20.0),
                          color: Colors.grey[200],
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                              [
                                defaultFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (value)
                                    {
                                      if(value!.isEmpty)
                                        return 'title must not be empty';
                                      return null;
                                    },
                                    label: "Title Task",
                                    prefIcon: Icons.title
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.number,
                                    validate: (value)
                                    {
                                      if(value!.isEmpty)
                                        return 'time must not be empty';
                                      return null;
                                    },
                                    label: "Time Task",
                                    prefIcon: Icons.watch_later_outlined,
                                    onTapFunction: ()
                                    {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value)
                                      {
                                        print(value!.format(context));
                                        timeController.text = value.format(context).toString();
                                      });
                                    }
                                ),

                                SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(
                                    controller: dataController,
                                    type: TextInputType.number,
                                    validate: (value)
                                    {
                                      if(value!.isEmpty)
                                        return 'date must not be empty';
                                      return null;
                                    },
                                    label: "Date Task",
                                    prefIcon: Icons.date_range_outlined,
                                    onTapFunction: ()
                                    {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime(2023)
                                      ).then((value)
                                      {
                                        // print(DateFormat.yMMMd().format(value));
                                        // dataController.text = DateFormat.yMMMd().format(value);

                                      });
                                    }
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0
                    ).closed.then((value){
                        cubit.changeFabIconAndBottomSheet(
                            isShow: false,
                            icon: Icons.edit
                        );
                    });
                    cubit.changeFabIconAndBottomSheet(
                        isShow: true,
                        icon: Icons.add
                    );
                  }
                  // insertToDatabase();
                },

              ),
              body: ConditionalBuilder(
                condition:state  is! AppGetLoading,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback:(context) => Center(child: CircularProgressIndicator()),

              ),
            );
          },
          listener: (context, state) {
            if(state is InsertToDBState)
            {
              Navigator.pop(context);
            }
          }
      )
    );
  }




}
