import 'package:flutter/material.dart';
import 'package:flutter_notes/src/note/note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notes = <Map<String, dynamic>>[];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
        backgroundColor: Color.fromRGBO(32, 29, 44, 1),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: List.generate(
              notes.length,
              (index) => Card(
                child: ListTile(
                  leading: Icon(Icons.book),
                  title: Text(notes[index]['title']),
                  subtitle: Text(notes[index]['subtitle']),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage()),
          ),
        },
        label: Text("criar"),
        tooltip: 'Increment',
        icon: Icon(Icons.add),
      ),
    );
  }
}
