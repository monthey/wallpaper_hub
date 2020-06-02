import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/CategoriesModel.dart';
import 'package:wallpaperhub/model/wallpaperModel.dart';
import 'package:wallpaperhub/screens/SearchScreen.dart';
import 'package:wallpaperhub/utils/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();

  TextEditingController _textEditingController = TextEditingController();

  getTrendingWallpapers() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=20&page=1",
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
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,

      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                        searchQuery: _textEditingController.text)));
                          },
                          child: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 80,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            title: categories[index].categorieName,
                            imgUrl: categories[index].imgUrl,
                          );
                        }),
                  ),
                  wallpapersGrid(wallpapers: wallpapers, context: context),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
