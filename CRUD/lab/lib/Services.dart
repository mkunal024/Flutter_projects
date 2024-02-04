import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employee.dart';

class Services {
  static const ROOT = 'http://localhost/Employees/employee_action';

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';

  static Future<String> createTable() async
  {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('CREATE TABLE Response : ${response.body}');
      return response.body;
    }
    catch (e) {
      return "Error";
    }
  }

  static Future<List<Employee>> getEmployees() async
  {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Get employees : ${response.body}');
      if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      }
      else {
        return List<Employee>.empty();
      }
    }
    catch (e) {
      return List<Employee>.empty();
    }
  }

  static List<Employee> parseResponse(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Employee> ((json)=>Employee.fromJson(json)).toList();
  }

  static Future<String> addEmployee(String firstName, String lastName) async
  {
    try{
      var map = Map<String,dynamic>();
      map['action']=_ADD_EMP_ACTION;
      map['first_name']= firstName;
      map['last_name']=lastName;
      final response = await http.post(Uri.parse(ROOT),body:map);
      print('Add employee Response: ${response.body}');
      if(200==response.statusCode)
        {
          return response.body;
        }
      else
        {
          return "error";
        }
    }
    catch(e)
    {
      return "Error";
    }
  }

  static Future<String> deleteEmployee(int empId) async
  {
    try{
      var map = Map<String,dynamic>();
      map['action']=_DELETE_EMP_ACTION;
      map['emp_id']=empId;
      final response = await http.post(Uri.parse(ROOT),body:map);
      print('Add employee Response: ${response.body}');
      if(200==response.statusCode)
      {
        return response.body;
      }
      else
      {
        return "error";
      }
    }
    catch(e)
    {
      return "Error";
    }
  }

  static Future<String> updateEmployee(int empId, String firstName, String lastName) async
  {
    try{
      var map = Map<String,dynamic>();
      map['action']=_UPDATE_EMP_ACTION;
      map['emp_id']=empId;
      map['first_name']= firstName;
      map['last_name']=lastName;
      final response = await http.post(Uri.parse(ROOT),body:map);
      print('Add employee Response: ${response.body}');
      if(200==response.statusCode)
      {
        return response.body;
      }
      else
      {
        return "error";
      }
    }
    catch(e)
    {
      return "Error";
    }
  }
}

