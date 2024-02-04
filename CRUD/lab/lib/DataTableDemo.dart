import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Employee.dart';
import 'Services.dart';

class DataTableDemo extends StatefulWidget
{
  DataTableDemo(): super();
  final String title = 'Flutter Data Table';

  @override
  State<StatefulWidget> createState()
  {
    return DataTableDemoState();
  }
}


class DataTableDemoState extends State<DataTableDemo> {
  late List <Employee> _employees;
  late GlobalKey <ScaffoldState> _scaffoldKey;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late Employee _selectedEmployee;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    //New enter
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Incremented"), duration: Duration(milliseconds: 300),),);
  }

  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _createTable() {
    _showProgress('Creating table ... ');
    Services.createTable().then((result) {
      if ('success' == result) {
        _showSnackBar(context, result);
      }
    });
  }

  _getEmployees() {

  }

  _updateEmployee() {

  }


//ui
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text(_titleProgress),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _createTable();
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getEmployees();
                },
              ),
            ]
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration.collapsed(hintText: 'First Name'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration.collapsed(hintText: 'Last Name'),
                ),
              ),
              _isUpdating
                  ? Row(
                children: <Widget>[
                  OutlinedButton(
                    child: Text('UPDATE'),
                    onPressed: () {
                      _updateEmployee();
                    },
                  ),
                  OutlinedButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      setState(() {
                        _isUpdating = false;
                      });
                      _clearValues();
                    },
                  ),
                ],
              )
                  : Container(),
            ],
          ),
        ));
  }
}