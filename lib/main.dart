import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imtihon/model/information_api.dart';
import 'package:imtihon/screens/info_page.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List wordList = ["Lenta", "Ko'ngilochar", "Dasturlash", "Qiziqarli", "Qiziq"];
  List bottomList = [
    [
      Icons.home,
      CupertinoIcons.play_rectangle,
      Icons.grid_view,
      Icons.person_outline_sharp
    ],
    ["Bosh Sahifa", "Video", "Kategoriya", "Profil"],
    [false, false, false, false]
  ];
  List? underList;
  @override
  void initState() {
    underList = List.generate(6, (index) => false);
    underList![0] = true;
    bottomList[2][0] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 35),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Icon(Icons.menu),
        title: Row(
          children: [
            Text(
              "IP",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              "Yangiliklar",
              style: TextStyle(color: Colors.amber, fontSize: 25),
            ),
          ],
        ),
        actions: [
          Icon(
            CupertinoIcons.search,
          ),
          SizedBox(
            width: 23,
          ),
          Icon(Icons.notifications_none_outlined),
          SizedBox(
            width: 17,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            width: 400,
            child: ListView.builder(
              itemCount: wordList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          underList = List.generate(6, (index) => false);
                          underList![index] = true;
                        });
                      },
                      child: Text(
                        "${wordList[index]}",
                        style: TextStyle(
                            fontSize: 18,
                            color: underList![index]
                                ? Colors.purple
                                : Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 4,
                      width:
                          underList![index] ? wordList[index].length * 8.0 : 0,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4))),
                    )
                  ],
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: _getPlaceholder(),
              builder: (context, AsyncSnapshot<List<Information>> snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return CupertinoActivityIndicator();
                } else if (snap.connectionState == ConnectionState.done) {
                  var data = snap.data;
                  return Container(
                    height: 619.1,
                    width: 392,
                    color: Colors.grey[300],
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 619,
                          width: 392,
                          child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoPage(data: snap,index: index,)));
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 7),
                                  padding: EdgeInsets.fromLTRB(10, 15, 20, 10),
                                  height: 200,
                                  width: 392,
                                  decoration: BoxDecoration(
                                      gradient: makeGradient(),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 170,
                                              height: 80,
                                              child: Text(
                                                data[index].name.toString(),
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          SizedBox(height: 10),
                                          Text(
                                            "Id: " + data[index].id.toString(),
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 200,
                                        width: 160,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          'https://source.unsplash.com/random/$index'),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Icon(Icons.favorite,
                                                    color: Colors.grey))
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: .9,
                            child: Container(
                              width: 400,
                              height: 70,
                              color: Colors.white,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            bottomList[2] = List.generate(
                                                4, (index) => false);
                                            bottomList[2][index] = true;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Icon(
                                                bottomList[0][index],
                                                size: 35,
                                                color: bottomList[2][index]
                                                    ? Colors.purple
                                                    : Colors.grey,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${bottomList[1][index]}',
                                                style: TextStyle(
                                                  color: bottomList[2][index]
                                                      ? Colors.purple
                                                      : Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center();
                }
              }),
        ],
      ),
    );
  }

  Future<List<Information>> _getPlaceholder() async {
    var url = "https://jsonplaceholder.typicode.com/comments";
    var respons = await http.get(Uri.parse(url));
    if (respons.statusCode == 200) {
      return (json.decode(respons.body) as List)
          .map((e) => Information.fromJson(e))
          .toList();
    } else {
      throw Exception("XATO");
    }
  }
  Color makeColor(){
    List colors = [
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.redAccent,
      Colors.teal,
      Colors.green,
      Colors.lime
    ];
    int son = Random().nextInt(7);
    return colors[son];
  }
 LinearGradient makeGradient(){
   List gradients = [
     LinearGradient(colors: [makeColor(),makeColor()]),
     LinearGradient(colors: [makeColor(),makeColor()]),
     LinearGradient(colors: [makeColor(),makeColor()]),
     LinearGradient(colors: [makeColor(),makeColor()]),
     LinearGradient(colors: [makeColor(),makeColor()]),
     LinearGradient(colors: [makeColor(),makeColor()]),
   ];
   var son = Random().nextInt(6);
   return gradients[son];
 }
}
