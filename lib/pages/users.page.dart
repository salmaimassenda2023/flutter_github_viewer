import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github_viewer/pages/home.page.dart';
import 'package:http/http.dart' as http;


class UserPage extends StatefulWidget{
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // attributes
  String query='';
  TextEditingController textEditingController = new TextEditingController();
  bool isObscure=false;
  dynamic data;

  // methods
 void  _Search(String query){
   String url = "https://api.github.com/search/users?q=${query}";
   http.get(Uri.parse(url))
       .then((response){
         print(url);
         setState(() { this.data=json.decode(response.body); });
       }).catchError((onError){   print(onError); });
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Page => ${query}")),
      body: Center(
        child:Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      obscureText: isObscure,
                      onChanged: (value)=>{
                        setState(() {
                        this.query=value;
                        })
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          suffixIcon:IconButton(
                              onPressed:(){
                                setState(() {this.isObscure=!this.isObscure;});
                                },
                              icon: Icon(this.isObscure==false?Icons.visibility:Icons.visibility_off
                          ),
                          ),
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(width: 1, color: Colors.blue)
                          )
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                  setState(() {
                    this.query=textEditingController.text;
                    _Search(query);
                  });
                }, icon: Icon(Icons.search),color: Colors.blue)
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: (data==null)?0:data['items'].length ,
                  itemBuilder: (context,index){
                    return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GitRepoPages(data['items'][index]['login'] ),
                            ),
                          );
                        },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage("${data['items'][index]['avatar_url']}"),
                                radius: 30,
                              ),
                              SizedBox(width: 20),
                              Text("${data['items'][index]['login']}"),
                            ],
                          ),
                          CircleAvatar(
                            child: Text("${data['items'][index]['score']}"),
                            radius: 20,
                          ),
                        ],
                      )
                    );
                },
              ),
            )
          ],
        )
      ),
    );
  }
}