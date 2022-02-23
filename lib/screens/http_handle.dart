import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpHandle extends StatefulWidget {
  const HttpHandle({Key? key}) : super(key: key);

  @override
  State<HttpHandle> createState() => _HttpHandleState();
}

class _HttpHandleState extends State<HttpHandle> {
  List posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future:
                        _getUrl('https://jsonplaceholder.typicode.com/posts'),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Oops, error: ${snapshot.error}');
                      }
                      // if (!snapshot.hasData) {
                      //   return Text('There is nothing to show');
                      // }

                      print(posts.length);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (ctx, i) => ListTile(
                          title: Text(posts[i]['title']),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getUrl(String url) async {
    var parsedUrl = Uri.parse(url);
    Response response = await get(parsedUrl);
    posts = [...jsonDecode(response.body)];
    posts.forEach((element) {
      print(element['title']);
    });
  }
}
