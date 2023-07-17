import 'package:TaskFlow/presentation/screens/new_goals_screen.dart';
import 'package:flutter/material.dart';

class ListGoalScreen extends StatelessWidget {
  const ListGoalScreen({Key? key, required this.projectID}) : super(key: key);
  final String projectID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Metas'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewGoalScreen(projectID: projectID),
                                    ));
                //Navigator.pushNamed(context, 'newGoal');
              },
              icon: const Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(children: [
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color:const Color.fromARGB(255, 255, 245, 216)),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
