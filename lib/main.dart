import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Consumption App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '';
  String _currency = 'Dollars';
  final double _formDistance = 5.0;
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  TextEditingController distanceController = new TextEditingController();
  TextEditingController avgController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Distance',
                  hintText: 'e.g 124',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: avgController,
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Distance per Unit',
                  hintText: 'e.g 17',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(child:
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: 'Price',
                      hintText: 'e.g 1.65',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ),
                  Container(width: _formDistance*5),
                  Expanded(child:
                  DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currency,
                      onChanged: (String value) {
                        _onDropdownChanged(value);
                      }),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(child:
                ElevatedButton(
                  child: Text('Submit', textScaleFactor: 1.5),
                  onPressed: () {
                    setState(() {
                      result = _calculate();
                    });
                  },
                ),
                ),
                Expanded(child:
                ElevatedButton(
                  child: Text('Reset', textScaleFactor: 1.5),
                  onPressed: () {
                    setState(() {
                      _reset();
                    });
                  },
                ),
                ),
              ],
            ),

            Text(result),
          ],
        ),
      ),
    );
  }

  _onDropdownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _avg = double.parse(avgController.text);
    double _price = double.parse(priceController.text);
    double _total = (_distance / _avg) * _price;
    String _result = 'The total price of your trip is ' +
        _total.toStringAsFixed(2) +
        ' ' +
        _currency;
    return _result;
  }
  void _reset(){
    distanceController.text ='';
    avgController.text='';
    priceController.text='';
    setState(() {
      result = '';
    });
  }
}
