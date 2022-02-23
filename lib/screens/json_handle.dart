import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonHandleScreen extends StatefulWidget {
  const JsonHandleScreen({Key? key}) : super(key: key);

  @override
  State<JsonHandleScreen> createState() => _JsonHandleScreenState();
}

class _JsonHandleScreenState extends State<JsonHandleScreen> {
  List<dynamic> data = [];
  bool _isLoading = true;
  String _errorMessage = '';

  Future<String> _loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/database.json');
    setState(() {
      try {
        print(jsonText);
        data = json.decode(jsonText);
      } catch (e) {
        print(e);
        _errorMessage = 'Error loading json';
        rethrow;
      } finally {
        _isLoading = false;
      }
    });
    return 'sucess';
  }

  @override
  void initState() {
    this._loadJsonData();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _errorMessage != ''
                  ? Center(child: Text(_errorMessage))
                  : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: Text(data[i]['title']),
                            );
                          },
                        ),
                      ],
                    )),
    );
  }
}
