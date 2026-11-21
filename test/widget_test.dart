import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  test('computeTip calculates tip and total accurately', () {
    final result = computeTip(500, 15);
    expect(result.tip, closeTo(75.00, 1e-9));
    expect(result.total, closeTo(575.00, 1e-9));
  });

  testWidgets('shows validation message for invalid bill input', (tester) async {
    await tester.pumpWidget(const TipApp());
    await tester.enterText(find.byType(TextField), 'abc');
    await tester.pump();

    expect(find.text('Enter a valid amount'), findsOneWidget);
  });
}

