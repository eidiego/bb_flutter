import 'package:flutter/material.dart';

import '../models/contact.dart';
import 'contact_form.dart';

class ContactsList extends StatelessWidget {
  ContactsList({Key? key}) : super(key: key);

  final List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    contacts.add(Contact(0, 'Diego ', 1200));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Contact contact = contacts[index];
          return _ContactItem(contact);
        },
        itemCount: contacts.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ),
              )
              .then(
                (newContact) => debugPrint(newContact.toString()),
              );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            contact.accountNumber.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
