import 'dart:io';

// import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final picker = ImagePicker();
  final pdf = pw.Document();
  File? _image;
 
  
  optionsdialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {pickImage(ImageSource.gallery);Navigator.pop(context);} ,
              child: Text("gallery"),
            ),
            SimpleDialogOption(
              onPressed: () {pickImage(ImageSource.camera);Navigator.pop(context);} ,
              child: Text("camera"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: Text("cancel"),
            ),
          ],
        );
      },
    );
  }

  Future pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("image to pdf"),
        centerTitle: true,
        elevation: 5,
      ),
            floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _image == null?
          Container():
          FloatingActionButton(
            onPressed: () {
                createPDF();
                savePDF();},
            child: Icon(Icons.picture_as_pdf, size: 26),
            heroTag: null,
            backgroundColor: Colors.red,
          ),
          SizedBox(
            height: 11,
          ),
          FloatingActionButton(
            onPressed: () {optionsdialog(context);},
            child: Icon(Icons.add_a_photo, size: 26),
            heroTag: null,
            backgroundColor: Colors.red,
          ),
        ],
      ),
      body: _image != null
          ? Container(
              height: 400,
              width: double.infinity,
              margin: EdgeInsets.all(8),
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
              ))
          : Container(),
    );
  }


  createPDF() async {
    final image = pw.MemoryImage(_image!.readAsBytesSync());

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context contex) {
          return pw.Center(child: pw.Image(image));
        }));
  }

  savePDF() async {
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/filename.pdf');
      await file.writeAsBytes(await pdf.save());
              var snackBar = SnackBar(content: Text('save'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
//add/24566
      // s&howPrintedMessage('success', 'saved to documents');
    } catch (e) {
              var snackBar = SnackBar(content: Text('Hello World'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // showPrintedMessage('error', e.toString());
    }
  }

  // showPrintedMessage(String title, String msg) {
  //   Flushbar(
  //     title: title,
  //     message: msg,
  //     duration: Duration(seconds: 3),
  //     icon: Icon(
  //       Icons.info,
  //       color: Colors.blue,
  //     ),
  //   )..show(context);
  // }
}
