import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:list_maker/model/model.dart';
import 'package:list_maker/database/db_operator.dart';

void main() => runApp(const MyApp());

/// main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'My Wishlist';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title:
            const Text(_title,
              style:
                TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
            ),
          shape: Border(
              bottom: BorderSide(
                  color: Colors.black,
                  width: 4
              )
          ),
          elevation: 4,
          backgroundColor: Colors.blue[700],
        ),
        body: ListWidget(),
      ),
    );
  }
}

/// stateful widget that the main application instantiates
class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);




  @override
  State<ListWidget> createState() => _ListWidgetState();
}

enum Field {name, price, amount}

var controlField = <Field, TextEditingController>{
  Field.name: TextEditingController(),
  Field.price: TextEditingController(),
  Field.amount: TextEditingController()
};
var labelField = <Field, String>{
  Field.name: 'Item',
  Field.price: 'Price',
  Field.amount: 'Amount'
};

class _ListWidgetState extends State<ListWidget> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TobuyOperator _tobuyOperator = TobuyOperator();

  late var controlField = <Field, TextEditingController>{
    Field.name: _nameController,
    Field.price: _priceController,
    Field.amount: _amountController
  };

  //Field _selectedFieldChange = Field.name;

  List<Tobuy> _tobuys = [];

  bool _canShowButton = false;

  void hideButton(bool state) {
    setState(() {
      _canShowButton = !state;
    });
  }


  @override
  void initState() {
    super.initState();
    _loadTobuys();
  }

  void _loadTobuys() async {
    final tobuys = await _tobuyOperator.getAllTobuys();
    setState(() {
      _tobuys = tobuys;
    });
  }

  void _addTobuy() async {
    final name = _nameController.text;
    final price = double.parse(_priceController.text);
    final amount = int.parse(_amountController.text);
    if (name.isNotEmpty && _priceController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      final tobuy = Tobuy(name: name, price:  price, amount: amount);
      await _tobuyOperator.insert(tobuy);
      _nameController.clear();
      _priceController.clear();
      _amountController.clear();
      _canShowButton = false;
      _loadTobuys();
    }
  }

  void _updateTobuy(Tobuy tobuy) async {
    final updatedTobuy = Tobuy(
      id: tobuy.id,
      name: _nameController.text,
      price: double.parse(_priceController.text),
      amount: int.parse(_amountController.text),
    );
    await _tobuyOperator.update(updatedTobuy);
    _nameController.clear();
    _priceController.clear();
    _amountController.clear();
    _loadTobuys();
  }

  void _deleteTobuy(int id) async {
    await _tobuyOperator.delete(id);
    _nameController.clear();
    _priceController.clear();
    _amountController.clear();
    _loadTobuys();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Tobuy _selectedNow= Tobuy(name: "");

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.lightBlueAccent[100],
        key: _scaffoldKey,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Wishlisted item'),
                    ),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                    ),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(labelText: 'Amount'),
                    ),
                    Container(
                      //color: Colors.blueAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith(
                                    (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.pressed)) return Colors.lightBlueAccent[500];
                                  return Colors.lightBlueAccent[200]; // Use the component's default color for other states
                                },
                              ),
                            ),
                            onPressed: () {
                              _addTobuy();
                              hideButton(true);
                            },
                            child: const Text('Add \nItem',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black)
                            ),
                          ),
                          if (_canShowButton)
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.resolveWith(
                                      (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.pressed)) return Colors.lightBlueAccent[500];
                                    return Colors.lightBlueAccent[200]; // Use the component's default color for other states
                                  },
                                ),
                              ),
                              onPressed: () {
                                _updateTobuy(_selectedNow);
                                hideButton(true);
                              },
                              child: const Text('Update \nItem',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black)
                              ),
                            ),
                          if(_canShowButton)
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.resolveWith(
                                        (Set<WidgetState> states) {
                                      if (states.contains(WidgetState.pressed)) return Colors.lightBlueAccent[500];
                                      return Colors.lightBlueAccent[200]; // Use the component's default color for other states
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  _deleteTobuy(_selectedNow.id!);
                                  hideButton(true);
                                },
                                child: const Text('Remove \nItem',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black)
                                ),
                          ),
                        ],
                      )

                    ),

                    /*
                    ElevatedButton(
                      onPressed: () {
                        _tobuyOperator.dropAll();
                      },
                      child: Text('DROP TABLE'),
                    ),
                    */

                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tobuys.length,
                  itemBuilder: (context, index) {
                    final tobuy = _tobuys[index];
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.blueGrey),
                        top: BorderSide(color: Colors.blueGrey)),
                      ),
                      child:
                        ListTile(
                          title: Text(tobuy.name),
                          subtitle:
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(tobuy.amount.toString())
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(" for " + tobuy.price.toString() + " Rs." ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Total: " + (tobuy.price! * (tobuy.amount)!.toDouble()).toString() + " Rs." ),
                                  ],
                                )
                              ],
                            ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _nameController.text = tobuy.name;
                              _priceController.text = tobuy.price.toString();
                              _amountController.text = tobuy.amount.toString();
                              hideButton(false);
                              _selectedNow = tobuy;

                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      );
  }
}