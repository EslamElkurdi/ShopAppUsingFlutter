import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/layout/shop_app/cubit/cubit.dart';
import 'package:loginscreen/models/shop_app/favorites_model.dart';
import 'package:loginscreen/modules/news_app/web_view/web_view.dart';
import 'package:loginscreen/shared/cubit/cubit.dart';
import 'package:loginscreen/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function? function(),
  required String buttonName,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? buttonName.toUpperCase() : buttonName,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  required IconData prefIcon,
  Function? onTapFunction()?,
  IconData? sufx,
  Function? onChange(String? value)?,
  bool secureText = false,
  Function? onTapSuff()?,
  String? Function(String?)? onSubmit
}) =>
    TextFormField(

      validator: validate,

      keyboardType: type,
      controller: controller,
      onTap: onTapFunction,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: secureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefIcon,
        ),
        labelText: label,
        suffixIcon: sufx != null
            ? IconButton(
                icon: Icon(sufx),
                onPressed: onTapSuff,
              )
            : null,
      ),
    );

Widget BuildTaskItem({required Map model, context}) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (Dismissible) {
        AppCubit.get(context).deleteDB(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundColor: Colors.blue,
              child: Text(
                "${model['time']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${model['data']}",
                    style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .UpdateDB(status: 'done', id: model['id']);
                },
                icon: Icon(Icons.check_box)),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .UpdateDB(status: 'archived', id: model['id']);
                },
                icon: Icon(Icons.archive_outlined))
          ],
        ),
      ),
    );

Widget tasksBuilder({required List<Map> cubit}) => ConditionalBuilder(
    condition: cubit.length > 0,
    builder: (context) {
      return ListView.separated(
          itemBuilder: (context, index) =>
              BuildTaskItem(model: cubit[index], context: context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit.length);
    },
    fallback: (context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              "No Tasks Yet",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    });

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem({required article, required context}) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage('${article['urlToImage']}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                height: 100.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${article['title']}",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget builder({article, isSearch = false}) => ConditionalBuilder(
    condition: article.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(article: article[index], context: context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 15),
    fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()));

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget
    ),
    (route) => false
);

Widget defaultTextButton({
  required Function? function(),
  required String text
})=> TextButton(
    onPressed: function,
    child: Text(
      '${text.toUpperCase()}'
    )
);

void showToast({
  required String text,
  required ToastStata state,
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStata{SUCCESS, ERROR, WARNING}

Color choseToastColor(ToastStata state)
{
  Color color;
  switch(state){
    case ToastStata.SUCCESS:
      color =  Colors.green;
      break;
    case ToastStata.WARNING:
      color =  Colors.amber;
      break;
    case ToastStata.ERROR:
      color =  Colors.red;
      break;

  }
  return color;
}

void showToastMessage(String message){
  Fluttertoast.showToast(
      msg: message, //message to show toast
      toastLength: Toast.LENGTH_LONG, //duration for message to show
      gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
      timeInSecForIosWeb: 6, //for iOS only
      //backgroundColor: Colors.red, //background Color for message
      textColor: Colors.black, //message text color
      fontSize: 16.0 //message font size
  );
}

Widget buildListItem(model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:
      [
        Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage("${model?.image}"),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              if(model?.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all( 3.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white
                    ),
                  ),
                ),
            ]
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model?.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model?.price.toString()}',
                    style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if( model?.discount != 0 && model?.discount != null)
                    Text(
                      '${model?.oldPrice.toString()}',
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model?.id??0);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:  ShopCubit.get(context).favorites[model?.id] == true
                            ? defaultColor
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);