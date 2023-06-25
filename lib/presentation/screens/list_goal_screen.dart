import 'package:flutter/material.dart';

class ListGoalScreen extends StatelessWidget {

  const ListGoalScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('List Goals'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_box_rounded, color: Colors.white,),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('ListGoalScreen'),
      ),
    );
  }
}