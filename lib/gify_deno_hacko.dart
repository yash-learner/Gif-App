import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class HackOnPage extends StatefulWidget {
  @override
   _HackOnPageState createState() => _HackOnPageState();
}
class _HackOnPageState extends State<HackOnPage> {
  bool isLoading = false;
  List data;
  final TextEditingController controller = TextEditingController(); // controls the data in text field
  String url = "https://api.giphy.com/v1/gifs/search?api_key=WkpWJ3J8fTi09I52XNjF9mrjoIUF4vYZ&limit=25&offset=0&rating=G&lang=en&q=";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  getjsondata(String searchInput) async {
     isLoading = true;
     setState(() {});
     var response = await http.get(Uri.encodeFull(url+searchInput),);
     print(response.body);
       var convertDatatoJson = json.decode(response.body)["data"];
       data = convertDatatoJson;
       print(data);
      setState(() {
        isLoading = false;
      });
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
        appBar:AppBar(
        title:Text("Gif App"),
      ),
       body:Column(
         children: <Widget>[
           Container(
             child: Row(
                     children: <Widget>[
                       Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                               labelText: 'Search Here'
                           ),
                         ),
                            ),
                       ),
                       RaisedButton(
                         color: Colors.grey[200], 
                         child: Text("Go"),
                         onPressed: () {
                           getjsondata(controller.text);
                         },
                       ),
                     ],
                      ),   
           ),
           Expanded(
               child: GridView.builder(
               gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isMobile?2:3,
                childAspectRatio: 2.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                ) , 
               itemCount:data!=null?data.length:0,
               itemBuilder:(BuildContext context ,int  index) { 
                 if (isLoading){
                   return CircularProgressIndicator().centered();
                 }
                 else{
                 final url = data[index]["images"]["fixed_height"]["url"].toString();
                 return Image.network(url,fit:BoxFit.fill,).card.roundedSM.make();
                 }
               }
               ),
           ),
         ],
       ),
      );
  }
} 