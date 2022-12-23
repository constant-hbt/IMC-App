import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados";

  void _resetField(){
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }
  
  void _calculateIMC(){
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    String msg = "";

    if(imc < 18.6){
      msg = 'Abaixo do peso';
    }
    else if(imc >= 18.6 && imc < 24.9){
      msg = 'Peso Ideal';
    }
    else if(imc >= 24.9 && imc < 29.9){
      msg = 'Levemente Acima do Peso';
    }
    else if(imc >= 29.9 && imc < 34.9){
      msg = 'Obesidade Grau I';
    }
    else if(imc >= 34.9 && imc < 39.9){
      msg = 'Obesidade Grau II';
    }
    else if(imc >= 40){
      msg = 'Obesidade Grau III';
    }

    setState(() {
      _infoText = '$msg (${imc.toStringAsPrecision(4)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cacluladora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: _resetField,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView( //Faz com que seja possivel dar scroll
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                controller: weightController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Insira seu peso';
                  }else{
                    double weight = double.tryParse(value) ?? 0;
                    if(!(weight > 0 && weight <= 300)){
                      return 'Insira um peso válido';
                    }
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text(
                    'Peso em kg',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Insira sua altura';
                  }else{
                    double height = double.tryParse(value) ?? 0.0;
                    if(!(height > 0 && height <= 300)){
                      return 'Insira uma altura válida';
                    }
                  }
                },
                decoration: const InputDecoration(
                  label: Text(
                    'Altura em cm',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,),
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState != null && _formKey.currentState!.validate()){
                        _calculateIMC();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
