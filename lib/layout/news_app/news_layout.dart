import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/news_app/cubit/cubit.dart';
import 'package:loginscreen/layout/news_app/cubit/states.dart';
import 'package:loginscreen/modules/news_app/search_screen/search_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppNewsCubit, NewsAppStates>(
      listener: (context, state){},
      builder: (context, state) {

        var cubit = AppNewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());

                  },
                  icon: Icon(Icons.search)
              ),
              IconButton(
                  onPressed: ()
                  {
                    cubit.toggleMode();
                  },
                  icon: Icon(Icons.brightness_4
                  ),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
                cubit.changeBottomNavBar(index);
            },
            items: cubit.items,
          ),
        );
      },
    );
  }
}
