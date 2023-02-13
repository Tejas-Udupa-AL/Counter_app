import 'package:flutter/material.dart';
import 'package:flutter_app/service/quote_service.dart';
import 'package:flutter_app/ui/home_page.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class CounterModel {
  final int counterValue;
  CounterModel(this.counterValue);
}

class CounterController {
  final _cachedCounterModel = BehaviorSubject<CounterModel>();
  CounterController(int startValue) {
    _cachedCounterModel.add(CounterModel(startValue));
  }

  ValueStream<CounterModel> get counterStream => _cachedCounterModel.stream;
  requestIncrementCounter() async {
    _cachedCounterModel.add(CounterModel(_cachedCounterModel.value.counterValue + 1));
  }

  generateErrorCase() {
    _cachedCounterModel.addError(CounterModel(-10));
  }
}

class QuotesModel {
  final String quote;
  QuotesModel(this.quote);
}

class QuotesController {
  final _cachedQuotesModel = BehaviorSubject<QuotesModel>();
  QuotesController() {
    requestUpdateQuote();
  }

  ValueStream get quoteStream => _cachedQuotesModel.stream;
  requestUpdateQuote() async {
    _cachedQuotesModel.add(QuotesModel(await QuotesService.requestQuote()));
  }
}
