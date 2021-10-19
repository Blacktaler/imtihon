import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imtihon/model/information_api.dart';

class InfoPage extends StatefulWidget {
  AsyncSnapshot<List<Information>> data;
  int index;

  InfoPage({required this.data, required this.index});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  double _sliderValue =15.0;
  bool height = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            setState(() {
              height = true;
            });
        }, icon: Icon(Icons.settings),color: Colors.black,),
        title: Text("InfoPage",
            style: GoogleFonts.lobster(
              fontSize: 25,
              color: Colors.black,
            )),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height:  height?100:0,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Slider(
                autofocus: true,
              min: 15,
              max: 40,
              divisions: 20,
              label: "$_sliderValue",
                value: _sliderValue,
                 onChanged: (v){
                setState(() {
                   _sliderValue = v;
                });
              },
              ),
                TextButton(onPressed: (){
                  setState(() {
                    height =false;
                  });
                }, child: Text("Save"))
            
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                            title: Column(
                              children: [
                                Text(
                                    "Bu buttonni bosdingizmi demak siz qariyasiz Shriftni O'lchamini O'zgartirish uchun buni"),
                                Icon(Icons.settings),
                                Text('Bosing')
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("qariyaman"))
                            ],
                          ));
                },
                child: Text(
                  "Qariyalar uchun",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
              child: Text(widget.data.data![widget.index].body.toString(),style: GoogleFonts.lobster(
                fontSize: _sliderValue
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
