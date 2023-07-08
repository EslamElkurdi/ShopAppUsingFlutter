import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/modules/shop_app/search/search_cubit/cubit.dart';
import 'package:loginscreen/modules/shop_app/search/search_cubit/states.dart';
import 'package:loginscreen/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                  color: Colors.black
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(

                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'please enter any String to search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefIcon: Icons.search,
                        onSubmit: (String? value){
                          SearchCubit.get(context).search(value.toString());
                        }
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 14.0,
                    ),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index)=> buildListItem(SearchCubit.get(context).model?.data?.data?[index], context),
                        separatorBuilder: (context, index)=> myDivider(),
                        itemCount: SearchCubit.get(context).model?.data?.data?.length??0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
