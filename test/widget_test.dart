import 'package:flutter_test/flutter_test.dart';

import 'package:shopper/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShopperApp());
  });
}
