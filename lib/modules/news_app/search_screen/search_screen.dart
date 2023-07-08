import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/news_app/cubit/cubit.dart';
import 'package:loginscreen/layout/news_app/cubit/states.dart';
import 'package:loginscreen/shared/components/components.dart';

class SearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var searchController = TextEditingController();

    return BlocConsumer<AppNewsCubit, NewsAppStates>(
        listener: (context, state){},
        builder: (context, state){
          var article = AppNewsCubit.get(context).search;
          
          
          return Scaffold(
            appBar: AppBar(

            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (value)
                    {
                        AppNewsCubit.get(context).getSearch(value!);
                    },
                    validate: (String? value)
                    {
                      if(value!.isEmpty){
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefIcon: Icons.search,
                  ),
                ),
                Expanded(child: builder(article: article, isSearch: true))
              ],
            ),
          );
        }
    );

  }
}