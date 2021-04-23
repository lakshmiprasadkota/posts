import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app_network_call_pratice/models/posts_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:post_app_network_call_pratice/network/base_network.dart';
import 'package:post_app_network_call_pratice/styles/app_color.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Posts imageLists = Posts();
  bool fetching = true;
  void getHttp() async {
    setState(() {
      fetching = true ;
    });
    try {
      Response response =
      await dioClient.ref.get("/get_memes");
      setState(() {
        imageLists = postsFromJson(jsonEncode(response.data)) ;
        var res = response;
        fetching = false;

        print(res);
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
        fetching = false;
      });
      print(e);
    }
  }
  @override
  void initState() {
    getHttp();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10 , left: 15 ,right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Home" , style: TextStyle(color: Color(0xfff5f8f6),
                  fontSize: 18, fontWeight: FontWeight.w500),),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8 , horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfff0a993)
                    ),
                    child: Icon(Icons.add , color: Colors.white,),
                  )

                ],
              ),
           SizedBox(height: 20,),

           Expanded(
             child:  SingleChildScrollView(
               child: NewWidget(meme: imageLists , fetching: fetching, imageList:imageLists ),
             ),
           )
            ],
          ),
        ),

      ),bottomNavigationBar: BottomNavigationBar(

      elevation: 0,
selectedItemColor: AppBGColors.iconBg,
      items: [

        BottomNavigationBarItem(icon: Icon(Icons.home)  , title: Text("Home") ,),
        BottomNavigationBarItem(icon: Icon(Icons.collections_outlined)  ,title: Text("Designs")),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline)  ,title: Text("Account")),
      ],
    )
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
    @required this.meme, this.fetching , this.imageList
  }) : super(key: key);

  final Posts meme;  final bool fetching ;  final  Posts imageList;

  @override
  Widget build(BuildContext context) {
    if (fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (imageList.data.memes.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return meme.data.memes.length==0 ? CircularProgressIndicator() :GridView.builder(
      itemCount: meme.data.memes.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:1,
          crossAxisCount: 2 ,crossAxisSpacing: 13, mainAxisSpacing: 13),
      itemBuilder: (context, index) {
        return  Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 200,
                  width: 200,
                  imageUrl: meme.data.memes[index].url,
                  fit: BoxFit.cover,
                  placeholder: (context,url) =>
                      Transform.scale(
                          scale: 0.2,
                          child: CircularProgressIndicator()),

                  errorWidget: (context,url,error) => Icon(Icons.error_outline)
              ),
            ),
          Positioned(
            bottom: 10,
            left: 10,
            child: RichText(
              text: TextSpan(text: meme.data.memes[index].name  ,
              style: TextStyle(color: Color(0xfff5f8f6) , fontWeight: FontWeight.w800,fontSize: 14),
              children: [
                TextSpan(text: "\n${meme.data.memes[index].boxCount} post" ,
                  style: TextStyle(color: Color(0xfff5f8f6) , fontWeight: FontWeight.w600,fontSize: 12),)
              ]),

            ),
          )

          ],
        );

      }



    );
  }
}
