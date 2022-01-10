import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AddNewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  AddNewTransaction({this.addNewTransaction});

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_nameController.text.isEmpty ||
        double.parse(_priceController.text) <= 0 ||
        _selectedDate == null) {
      return;
    } else {
      widget.addNewTransaction(
        _nameController.text,
        double.parse(_priceController.text),
        _selectedDate,
      );
    }

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((theDate) {
      if (theDate == null) {
        return;
      }

      setState(() {
        _selectedDate = theDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                controller: _priceController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date picked!'
                          : DateFormat.yMd().format(_selectedDate),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Pick the date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                color: Theme.of(context).accentColor,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
