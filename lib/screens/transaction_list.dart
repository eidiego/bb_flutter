import 'package:flutter/material.dart';

import '../components/centered_message.dart';
import '../components/progress.dart';

import '../http/webclients/transaction_webclient.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = new TransactionWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Transaction>>(
          future: Future.delayed(Duration(seconds: 1))
              .then((value) => _webClient.findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress(message: 'Carregando transações');
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction> transactions =
                      snapshot.data as List<Transaction>;
                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                }
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
                break;
            }
            return CenteredMessage('Unknown error');
          },
        ),
      ),
    );
  }
}
