import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileIOScreen extends StatefulWidget {
  FileIOScreen({Key? key}) : super(key: key);

  @override
  State<FileIOScreen> createState() => _FileIOScreenState();
}

class _FileIOScreenState extends State<FileIOScreen> {
  var _message = 'none';
  var _info = '';

  var _inputFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _inputFieldController,
            ),
            TextButton(
              child: Text('Click to write'),
              onPressed: _writeToFile,
            ),
            Text(_info),
            SizedBox(
              height: 30,
            ),
            TextButton(onPressed: _readFromFile, child: Text('Click to read')),
            Text(_message),
          ],
        ),
      ),
    );
  }

  Future<void> _writeToFile() async {
    Directory documents = await getApplicationDocumentsDirectory();

    try {
      File file = File('${documents.path}/test.txt');
      if (_inputFieldController.text.isNotEmpty) {
        await file.writeAsString(_inputFieldController.text);
        setState(() {
          _info = 'file has been writen to ${documents.path}';
        });
      } else {
        setState(() {
          _info = 'input text';
        });
      }
    } catch (e) {
      _message = 'Error: $e';
    }
  }

  Future<void> _readFromFile() async {
    Directory documents = await getApplicationDocumentsDirectory();

    try {
      File file = File('${documents.path}/test.txt');

      file.readAsString().then((String text) {
        setState(() {
          _message = 'text.txt has this text inside it:  $text';
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
