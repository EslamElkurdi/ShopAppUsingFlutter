import 'package:flutter/material.dart';
import 'package:loginscreen/models/user/user_model.dart';


class UserScreen extends StatelessWidget {

  List<UserModel> users = [
    UserModel(
        id: 1,
        name: "Eslam Gamal",
        phone: "01012078534"
    ),
    UserModel(
        id: 2,
        name: "Mahmoud Ahmed",
        phone: "0104545545"
    ),
    UserModel(
        id: 3,
        name: "Malak Ahmed",
        phone: "0115457447"
    ),
    UserModel(
        id: 4,
        name: "Ali Mahmoud",
        phone: "0113367454"
    ),
    UserModel(
        id: 1,
        name: "Eslam Gamal",
        phone: "01012078534"
    ),
    UserModel(
        id: 2,
        name: "Mahmoud Ahmed",
        phone: "0104545545"
    ),
    UserModel(
        id: 3,
        name: "Malak Ahmed",
        phone: "0115457447"
    ),
    UserModel(
        id: 4,
        name: "Ali Mahmoud",
        phone: "0113367454"
    ),
    UserModel(
        id: 1,
        name: "Eslam Gamal",
        phone: "01012078534"
    ),
    UserModel(
        id: 2,
        name: "Mahmoud Ahmed",
        phone: "0104545545"
    ),
    UserModel(
        id: 3,
        name: "Malak Ahmed",
        phone: "0115457447"
    ),
    UserModel(
        id: 4,
        name: "Ali Mahmoud",
        phone: "0113367454"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Users"
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length
      ),
    );
  }

  Widget buildUserItem(UserModel user) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                "${user.id}",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name}",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "${user.phone}",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey

                  ),
                ),
              ],
            ),

          ],
        ),
      );

  // build item -> Done
 // build list
// add item to list
}