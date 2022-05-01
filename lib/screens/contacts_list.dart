import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView(children: const <Widget>[
        Card(
          child: ListTile(
            title: Text(
              'Diego',
              style: TextStyle(fontSize: 24),
            ),
            subtitle: Text('1000', style: TextStyle(fontSize: 16)),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
