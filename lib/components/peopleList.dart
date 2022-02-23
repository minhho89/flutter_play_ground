import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/person.dart';

class PeopleListScreen extends StatefulWidget {
  const PeopleListScreen({Key? key}) : super(key: key);

  @override
  _PeopleListScreenState createState() => _PeopleListScreenState();
}

class _PeopleListScreenState extends State<PeopleListScreen> {
  Widget get scaffoldBody {
    return FutureBuilder(
        future: fetchPeople(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            return const Text('No people found');
          }

          final List<Person> people =
              Person.fromJsonArray(snapshot.data.toString());
          final List personTiles =
              people.map((Person person) => Widget personWidget(person)).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: scaffoldBody,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/peopleUpsert'),
      ),

      return GridView.extent(maxCrossAxisExtent: 300,
    children: personTitles,)
    );
  }

  void fetchPeople() {}

  Widget personWidget(Person person) {
    return Container();
  }
}
