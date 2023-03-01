import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  final String info;
  const NewPage({Key? key, required this.info}):super(key:key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Updates"),
      ),
      body: Center(
        child: Text(widget.info,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
        ),
      ),
    );
  }
}
