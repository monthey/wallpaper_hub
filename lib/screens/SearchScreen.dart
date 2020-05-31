import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/wallpaperModel.dart';
import 'package:wallpaperhub/utils/widgets.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  final searchQuery;

  const SearchScreen({Key key, this.searchQuery}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<WallpaperModel> wallpapers = new List();
  TextEditingController _textEditingController = TextEditingController();


  getSearchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=16",
        headers: {"Authorization": apiKey});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData["photos"].forEach((element) {
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
//        print(element);
      });
    } else {
      print(response.statusCode);
    }
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    _textEditingController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Color(0xFFF5f8fd),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          hintText: "Search Wallpapers....",
                          border: InputBorder.none),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child:                     Icon(Icons.search)
                    ,
                  ),
//                  Icon(Icons.search)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            wallpapersGrid(wallpapers: wallpapers, context: context),
          ],
        ),
      ),
    );
  }
}
