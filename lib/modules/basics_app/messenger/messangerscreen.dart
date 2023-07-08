import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://i0.wp.com/greatlakesledger.com/wp-content/uploads/2018/08/Are-we-Ready-to-Have-our-Own-Personal-Home-Robot.jpeg?fit=1240%2C849&ssl=1'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Chats",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 20.0,
                child: Icon(

                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20.0,
                ),
              )
          ),
          IconButton(
              onPressed: (){},
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 20.0,
                child: Icon(

                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      "Search",style: TextStyle(
                      fontSize: 18.0
                    ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index)=> BuildItemStory(),
                    separatorBuilder: (context , index)=> SizedBox(
                      width: 20.0,
                    ),
                    itemCount: 15
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index)=>BuildItemChat(),
                  separatorBuilder: (context, index)=>SizedBox(
                    height: 20.0,
                  ),
                  itemCount: 15
              )
            ],
          ),
        ),
      ),

    );
  }

  Widget BuildItemStory() => Container(
    width: 60.0,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://i.pinimg.com/736x/14/31/bc/1431bc5522630660d27b69ee59c2c71c.jpg'),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 2.0,
                end: 2.0,
              ),
              child: CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.green,
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          "Eslam Gamal mahmoud",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
  Widget BuildItemChat() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://i.pinimg.com/736x/14/31/bc/1431bc5522630660d27b69ee59c2c71c.jpg'),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 2.0,
              end: 2.0,
            ),
            child: CircleAvatar(
              radius: 8.0,
              backgroundColor: Colors.green,
            ),
          )
        ],
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Eslam Gamal Mahmoud Elkurdi Eslam Gamal Mahmoud Elkurdi",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(""
                      "hello there my name Islam hello there my name Islam hello there my name Islam ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blue
                    ),
                  ),
                ),
                Text(
                    "02:00 pm"
                )

              ],
            )
          ],
        ),
      )
    ],
  );
}
