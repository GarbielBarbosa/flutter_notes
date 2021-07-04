import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  final formKey = GlobalKey<FormState>();
  var title;
  var subtitle;

  void validade() {
    final form = formKey.currentState;
    if (form!.validate()) {
      print("title $title \n subtitle $subtitle");
      final map = Map<String, dynamic>();
      map.addAll({"title": title, "subtitle": subtitle});
      Navigator.pop(context, map);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "subtitle"),
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        validade();
                      },
                      child: Text("salvar"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
