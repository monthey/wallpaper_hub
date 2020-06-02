import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/wallpaperModel.dart';
import 'package:wallpaperhub/utils/widgets.dart';

class Categories extends StatefulWidget {

  final String categoryName;

  const Categories({Key key, this.categoryName}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<WallpaperModel> wallpapers = new List();


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
    getSearchWallpapers(widget.categoryName);
    super.initState();
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
