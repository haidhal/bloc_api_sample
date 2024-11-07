import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Product Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddProductScreen(),
    );
  }
}

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  double price = 0.0;
  int stock = 0;
  String category = 'electronics';

  // Form field controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  // Function to submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display the entered data
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Product Added'),
            content: Text('Name: $name\nDescription: $description\nPrice: \$$price\nStock: $stock\nCategory: $category'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Product Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              
              // Product Description
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              
              // Product Price
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number for price';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    price = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              
              // Product Stock Quantity
              TextFormField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the stock quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number for stock';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    stock = int.tryParse(value) ?? 0;
                  });
                },
              ),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: category,
                decoration: InputDecoration(labelText: 'Category'),
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
                items: ['electronics', 'clothing', 'home-goods', 'beauty', 'toys']
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),

              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
