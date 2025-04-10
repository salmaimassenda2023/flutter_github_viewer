import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class GitRepoPages extends StatefulWidget{
  //attributes
  String login;

  GitRepoPages(this.login);

  @override
  State<GitRepoPages> createState() => _GitRepoPagesState();
}

class _GitRepoPagesState extends State<GitRepoPages> {
  dynamic data;

  // methods
  Future<void> loadRepos() async {
    String url ='https://api.github.com/users/${widget.login}/repos';
    http.Response response = await http.get(Uri.parse(url)) ;
    if (response.statusCode == 200) {
      setState(() {
        this.data = json.decode(response.body);
        print(data);
      });
    } else {
      // Handle error
      print('Failed to load repos');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRepos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Repositories ${widget.login}")),
      body: Center(
       child: ListView.separated(
           itemBuilder: (
               (context,index)=>ListTile(
                 title: Text("${data[index]['name']}"),
               )
           ),
           separatorBuilder:
           (context,index)=>Divider(height: 2,),
           itemCount: data==null?0:data.length),
      ),
    );
  }
}













