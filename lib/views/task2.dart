import 'package:flutter/material.dart';

class ElementCompositionScreen extends StatefulWidget {
  @override
  _ElementCompositionScreenState createState() => _ElementCompositionScreenState();
}

class _ElementCompositionScreenState extends State<ElementCompositionScreen> {
  final TextEditingController cController = TextEditingController();
  final TextEditingController hController = TextEditingController();
  final TextEditingController sController = TextEditingController();
  final TextEditingController oController = TextEditingController();
  final TextEditingController wController = TextEditingController();
  final TextEditingController aController = TextEditingController();
  final TextEditingController vController = TextEditingController();
  final TextEditingController qCombController = TextEditingController();

  String output = '';

  void computeValues() {
    double c = double.tryParse(cController.text.replaceAll(',', '.')) ?? 0.0;
    double h = double.tryParse(hController.text.replaceAll(',', '.')) ?? 0.0;
    double s = double.tryParse(sController.text.replaceAll(',', '.')) ?? 0.0;
    double o = double.tryParse(oController.text.replaceAll(',', '.')) ?? 0.0;
    double w = double.tryParse(wController.text.replaceAll(',', '.')) ?? 0.0;
    double a = double.tryParse(aController.text.replaceAll(',', '.')) ?? 0.0;
    double v = double.tryParse(vController.text.replaceAll(',', '.')) ?? 0.0;
    double qCombValue = double.tryParse(qCombController.text.replaceAll(',', '.')) ?? 0.0;

    double dryMassCoeff = (100 - w - a) / 100;
    double cWork = c * dryMassCoeff;
    double hWork = h * dryMassCoeff;
    double sWork = s * dryMassCoeff;
    double oWork = o * dryMassCoeff;
    double vWork = v * (100 - w) / 100;
    double qR = qCombValue * dryMassCoeff - 0.025 * w;

    setState(() {
      output = """
Склад робочої маси:
- Вуглець (C): ${cWork.toStringAsFixed(2)}%
- Водень (H): ${hWork.toStringAsFixed(2)}%
- Сірка (S): ${sWork.toStringAsFixed(2)}%
- Кисень (O): ${oWork.toStringAsFixed(2)}%
- Ванадій (V): ${vWork.toStringAsFixed(1)} мг/кг
- Зола (A): ${a.toStringAsFixed(2)}%

Нижча теплота згоряння робочої маси: ${qR.toStringAsFixed(2)} МДж/кг
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор елементарного складу')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField('Вміст C (%)', cController),
              _buildTextField('Вміст H (%)', hController),
              _buildTextField('Вміст S (%)', sController),
              _buildTextField('Вміст O (%)', oController),
              _buildTextField('Вміст W (%)', wController),
              _buildTextField('Вміст A (%)', aController),
              _buildTextField('Вміст V (%)', vController),
              _buildTextField('Q_comb (МДж/кг)', qCombController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: computeValues,
                child: const Text('Обчислити'),
              ),
              const SizedBox(height: 20),
              Text(output, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }
}
