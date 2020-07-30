// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:testasgmttalkremit/models/Transaction.dart';

void main() {
  group('Amount', () {
    var list = [Transaction(paid: 1), Transaction(paid: 3)];

    //todo this test is bad. use util method /class for calculations
    var total = list.map((t) => t.paid).toList().reduce((a, b) => a + b);
    var avg = total / list.length;

    test('total send transactions amount', () {
      expect(total, 4);
    });

    test('average transactions amount', () {
      expect(avg, 2);
    });
  });
}
