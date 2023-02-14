import 'package:flutter/material.dart';
import 'package:flutter_app/service/quote_service.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterControllerObject = CounterController(0);
    final quotesControllerObject = QuotesController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter app'),
        ),
        body: Center(
          child: Column(children: [
            Consumer<QuotesService>(
              builder: (context, value, child) => StreamBuilder(
                stream: quotesControllerObject.quoteStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data?.quote);
                  } else if (snapshot.hasError) {
                    return const Text('Quote stream error');
                  }
                  return const Text('Loading quotes...');
                },
              ),
            ),
            StreamBuilder(
              stream: counterControllerObject.counterStream,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Counter ${snapshot.data?.counterValue}');
                } else if (snapshot.hasError) {
                  return const Text('Stream has error');
                }
                return const Text('Counter: ...');
              }),
            ),
            ElevatedButton(
              onPressed: () {
                counterControllerObject.requestIncrementCounter();
                quotesControllerObject.requestUpdateQuote();
              },
              child: const Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                counterControllerObject.generateErrorCase();
              },
              child: const Text('Error Case'),
            ),
          ]),
        ));
  }
}
