import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milk Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MilkDeliveryForm(),
    );
  }
}

class MilkDeliveryForm extends StatefulWidget {
  @override
  _MilkDeliveryFormState createState() => _MilkDeliveryFormState();
}

class _MilkDeliveryFormState extends State<MilkDeliveryForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  String _selectedProduct = 'Milk';
  bool _dailyUpdates = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delivery preferences submitted!')),
      );
      print("Name: $_name");
      print("Address: $_address");
      print("Product: $_selectedProduct");
      print("Daily Updates Subscribed: $_dailyUpdates");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Milk Delivery Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Delivery Address'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter your address' : null,
                onSaved: (value) => _address = value!,
              ),
              SizedBox(height: 20),
              Text('Select Product'),
              DropdownButtonFormField<String>(
                value: _selectedProduct,
                items: ['Milk', 'Curd', 'Paneer', 'Ghee']
                    .map((product) => DropdownMenuItem(
                  value: product,
                  child: Text(product),
                ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _selectedProduct = value!;
                }),
              ),
              SwitchListTile(
                title: Text('Subscribe to daily delivery updates'),
                value: _dailyUpdates,
                onChanged: (value) => setState(() {
                  _dailyUpdates = value;
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit Preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
