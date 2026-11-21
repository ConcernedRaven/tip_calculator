import 'package:material_ui/material_ui.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String rawText) => double.tryParse(rawText.trim());

({double tip, double total}) computeTip(double amount, int tipRate) {
  final tip = amount * tipRate / 100;
  return (tip: tip, total: amount + tip);
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _amountInput = TextEditingController();
  int _tipRate = 15;

  @override
  void dispose() {
    _amountInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parsedAmount = parseBill(_amountInput.text);
    final validAmount = parsedAmount != null && parsedAmount.isFinite && parsedAmount >= 0;
    final summary = validAmount ? computeTip(parsedAmount, _tipRate) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Tip Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountInput,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Bill amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 10, label: Text('10%')),
                ButtonSegment(value: 15, label: Text('15%')),
                ButtonSegment(value: 20, label: Text('20%')),
              ],
              selected: {_tipRate},
              onSelectionChanged: (picked) => setState(() => _tipRate = picked.first),
            ),
            const SizedBox(height: 24),
            if (summary == null)
              const Text('Enter a valid amount')
            else ...[
              Text('Tip ${summary.tip.toStringAsFixed(2)}'),
              const SizedBox(height: 6),
              Text('Total ${summary.total.toStringAsFixed(2)}'),
            ],
          ],
        ),
      ),
    );
  }
}


