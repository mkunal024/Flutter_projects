import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> countries = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/WorldDB/world_actions.php'));

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          countries = List<Map<String, dynamic>>.from(decodedData);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error as needed (e.g., show an error message to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continents'),
      ),
      body: Center(
        child: Container(
          width: 600,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Index')),
              DataColumn(label: Text('Continent')),
            ],
            rows: List<DataRow>.generate(
              countries.length,
                  (index) => DataRow(
                cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        String continent = countries[index]['Continent'];
                        String url = 'http://localhost/WorldDB/continent.php:$continent';
                        print('Tapped on $url');
                        // You can navigate to the URL or perform other actions here
                      },
                      child: Text('${countries[index]['Continent']}'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        tooltip: 'Fetch Data',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
