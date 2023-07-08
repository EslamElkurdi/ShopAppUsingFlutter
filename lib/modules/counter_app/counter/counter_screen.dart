import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/modules/counter_app/counter/counter_cubit/counter_states.dart';
import 'package:loginscreen/modules/counter_app/counter/counter_cubit/cubit.dart';

class CounterScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit , CounterStates>(
        listener: (context, state) {
          if(state is CounterMinusState) print('Minus State ${state.Counter}');
          if(state is CounterPlusState) print('Plus State');
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text(
                        "PLUS",
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "${CounterCubit.get(context).counter}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text(
                        "MINUS",
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


