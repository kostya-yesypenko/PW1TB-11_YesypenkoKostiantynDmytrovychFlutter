import 'package:flutter/material.dart';

class FuelCompositionScreen extends StatefulWidget {
  @override
  _FuelCompositionScreenState createState() => _FuelCompositionScreenState();
}

class _FuelCompositionScreenState extends State<FuelCompositionScreen> {
  final TextEditingController hController = TextEditingController();
  final TextEditingController cController = TextEditingController();
  final TextEditingController sController = TextEditingController();
  final TextEditingController nController = TextEditingController();
  final TextEditingController oController = TextEditingController();
  final TextEditingController wController = TextEditingController();
  final TextEditingController aController = TextEditingController();

  String output = '';

  void computeValues() {
    double h = double.tryParse(hController.text.replaceAll(',', '.')) ?? 0.0;
    double c = double.tryParse(cController.text.replaceAll(',', '.')) ?? 0.0;
    double s = double.tryParse(sController.text.replaceAll(',', '.')) ?? 0.0;
    double n = double.tryParse(nController.text.replaceAll(',', '.')) ?? 0.0;
    double o = double.tryParse(oController.text.replaceAll(',', '.')) ?? 0.0;
    double w = double.tryParse(wController.text.replaceAll(',', '.')) ?? 0.0;
    double a = double.tryParse(aController.text.replaceAll(',', '.')) ?? 0.0;

    double dryMassCoeff = 100 / (100 - w);
    double combustibleMassCoeff = 100 / (100 - w - a);

    double lhv = (339 * c + 1030 * h - 108.8 * (o - s) - 25 * w) / 1000;
    double lhvDry = (lhv + 0.025 * w) * dryMassCoeff;
    double lhvCombustible = (lhv + 0.025 * w) * combustibleMassCoeff;

    setState(() {
      output = """
Коефіцієнт для сухої маси: ${dryMassCoeff.toStringAsFixed(2)}
Коефіцієнт для горючої маси: ${combustibleMassCoeff.toStringAsFixed(2)}

Склад сухої маси:
H = ${(h * dryMassCoeff).toStringAsFixed(2)}%, C = ${(c * dryMassCoeff).toStringAsFixed(2)}%, 
S = ${(s * dryMassCoeff).toStringAsFixed(2)}%, N = ${(n * dryMassCoeff).toStringAsFixed(4)}%,  
O = ${(o * dryMassCoeff).toStringAsFixed(2)}%, A = ${(a * dryMassCoeff).toStringAsFixed(2)}%

Склад горючої маси:
H = ${(h * combustibleMassCoeff).toStringAsFixed(2)}%, C = ${(c * combustibleMassCoeff).toStringAsFixed(2)}%, 
S = ${(s * combustibleMassCoeff).toStringAsFixed(2)}%, N = ${(n * combustibleMassCoeff).toStringAsFixed(4)}%,  
O = ${(o * combustibleMassCoeff).toStringAsFixed(2)}%

Нижча теплота згоряння (робоча маса): ${lhv.toStringAsFixed(5)} МДж/кг
Нижча теплота згоряння (суха маса): ${lhvDry.toStringAsFixed(5)} МДж/кг
Нижча теплота згоряння (горюча маса): ${lhvCombustible.toStringAsFixed(5)} МДж/кг
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор складу палива')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Вміст H (%)', hController),
              _buildTextField('Вміст C (%)', cController),
              _buildTextField('Вміст S (%)', sController),
              _buildTextField('Вміст N (%)', nController),
              _buildTextField('Вміст O (%)', oController),
              _buildTextField('Вміст W (%)', wController),
              _buildTextField('Вміст A (%)', aController),
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
