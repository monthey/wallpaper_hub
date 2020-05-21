import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaperhub/model/wallpaperModel.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Wallpaper",
        style: GoogleFonts.openSans(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            letterSpacing: 1),
      ),
      Text("Hub",
          style: GoogleFonts.openSans(color: Colors.blue, letterSpacing: 1))
    ],
  );
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, title;

  const CategoryTile({Key key, @required this.imgUrl, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8)
            ),
            alignment: Alignment.center,
            height: 50,
            width: 100,
            child: Text(
              title,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 1),
            ),
          )
        ],
      ),
    );
  }
}

Widget wallpapersGrid({List<WallpaperModel> wallpapers, context}) {
  wallpapers.map((e) => print(e.src.portrait.toString()));

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(child: Container(
          color: Colors.blue,
          child: Image.network(wallpaper.src.portrait)
        ));
      }).toList()
    ),
  );
}
