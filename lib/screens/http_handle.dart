import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpHandle extends StatelessWidget {
  const HttpHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: TextButton(
            child: Text('HTTP GET'),
            onPressed: _httpGetTest,
          ),
        ),
      ),
    );
  }

  Future<void> _httpGetTest() async {
    var url = Uri.parse('https://us.com/people/1234');
    Response response = await get(url);
    print(response.statusCode);
  }
}
