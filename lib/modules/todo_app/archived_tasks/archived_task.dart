import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/cubit/app_states.dart';
import 'package:loginscreen/shared/cubit/cubit.dart';

class ArchivedTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state){
          var cubit = AppCubit.get(context).archivedTasks;

          return tasksBuilder(cubit: cubit);
        },
        listener: (context, state){}
    );
  }
}
