import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaperhub/model/wallpaperModel.dart';
import 'package:wallpaperhub/screens/Categories.dart';
import 'package:wallpaperhub/screens/ImageView.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
        text: 'Wallpaper',
        style: GoogleFonts.pacifico(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 25,
            letterSpacing: 1),
        children: <TextSpan>[
          TextSpan(
            text: "Hub",
            style: GoogleFonts.pacifico(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w300,
                letterSpacing: 1),
          )
        ]),
  );
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, title;

  const CategoryTile({Key key, @required this.imgUrl, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categories(
                      categoryName: title.toLowerCase(),
                    )));
      },
      child: Container(
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
                  borderRadius: BorderRadius.circular(8)),
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
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((WallpaperModel wallpaper) {
          return GridTile(
              child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgUrl: wallpaper.src.portrait,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/placeholder.jpg",
                        image: wallpaper.src.portrait,
                        fit: BoxFit.cover,
                      ))),
            ),
          ));
        }).toList()),
  );
}
