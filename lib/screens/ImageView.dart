import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;

  const ImageView({Key key, this.imgUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
//                    _snackbar();
                    globalKey.currentState.showSnackBar(SnackBar(content:Row(children: <Widget>[Icon(Icons.thumb_up,color: Colors.white,),SizedBox(width: 20,),Expanded(
                        child: Text("Wallpaper Saved in Gallery!"))],) ,backgroundColor: Colors.orangeAccent,elevation: 2.0,));
                   Timer(Duration(seconds: 3), _save());
//                    _save();
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1B1B).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [Color(0x36FFFFFF), Color(0x0FFFFFF)])),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Set Wallpaper",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white,fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Image will be saved to gallery",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if(Platform.isIOS){
      await _askPermission();
    }
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }


  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    } else {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      print(permission);
    }
  }

}


