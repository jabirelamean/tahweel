import 'package:flutter/material.dart';

class NewView extends StatelessWidget {
  const NewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
