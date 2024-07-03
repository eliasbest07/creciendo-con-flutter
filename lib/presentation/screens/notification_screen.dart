import 'package:TaskFlow/presentation/drawables/filter_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
// la lista de notificaciones del usuario 
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 246, 249, 255),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('NOTIFICACIONES', style: TextStyle(color: Colors.white),),
        leading:  IconButton(
            onPressed: () {
              //Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white)
          ),
        actions:[
          IconButton(
            onPressed: () {},
            icon: SizedBox(
              height: 20,
              width: 20,
              child: CustomPaint(
                size: Size.infinite,
                painter: FilterIcon( color: Colors.white ),
              ),
            ),
          )
        ]
      ),
      body: Column(children: [
        SizedBox(
          width: double.infinity,
          height: size.height*0.45,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top:30.0, left: 15,right: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      // Navigator.push(context,MaterialPageRoute(builder: (context) => DismissibleWidget(),));
                    },
                    child: Text('Nuevas'))),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slidable(
  key: const ValueKey(0),

  startActionPane: ActionPane(
    motion: const ScrollMotion(),

    dismissible: DismissiblePane(onDismissed: () {}),

    children: [
      SlidableAction(
        onPressed:  (context){},
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Delete',
      ),
      SlidableAction(
        onPressed:  (context){},
        backgroundColor: Color(0xFF21B7CA),
        foregroundColor: Colors.white,
        icon: Icons.share,
        label: 'Share',
      ),
    ],
  ),

  endActionPane: ActionPane(
    motion: ScrollMotion(),
    children: [
      SlidableAction(
        flex: 2,
        onPressed: (context){},
        backgroundColor: Color(0xFF7BC043),
        foregroundColor: Colors.white,
        icon: Icons.archive,
        label: 'Archive',
      ),
      SlidableAction(
        onPressed: (context){},
        backgroundColor: Color(0xFF0392CF),
        foregroundColor: Colors.white,
        icon: Icons.save,
        label: 'Save',
      ),
    ],
  ),

  child: Container( 
    height:150,
    width: double.infinity,
    decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white
    ),
    child: Row(children: [
      SizedBox(
        height: 150,
        width: 150,
        child: Stack(children: [
          Positioned(
            top: 20,
            left: 20,
            child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 3, color: const Color.fromARGB(255, 102, 102, 102)),
            color: Colors.white,),
            )),
            Positioned(
            top: 50,
            left: 50,
            child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 3, color: const Color.fromARGB(255, 102, 102, 102)),
            color: Colors.white),
            ))
        ],))
    ],),
  ) //const ListTile(title: Text('Slide me')), // este es el card
),
                  
                ),
              ),
              )
            ],
          ),
        ),
        // SizedBox(
        //   width: double.infinity,
        //   height: size.height*0.45,
        //   child: Column(
        //     children: [
        //       Text('Leidas'),
        //       Expanded(
        //         child: ListView.builder(
        //           itemCount: 10,
        //           itemBuilder: (context, index) => Dismissible(
        //         key: UniqueKey(),
        //         background: Container(
        //           color: Colors.red,
        //           child: Align(
        //             alignment: Alignment.centerLeft,
        //             child: Padding(
        //       padding: const EdgeInsets.only(left: 16.0),
        //       child: Icon(Icons.delete, color: Colors.white),
        //             ),
        //           ),
        //         ),
        //         secondaryBackground: Container(
        //           color: Colors.green,
        //           child: Align(
        //             alignment: Alignment.centerRight,
        //             child: Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: Icon(Icons.archive, color: Colors.white),
        //             ),
        //           ),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             height: 40,
        //             width: double.infinity,
        //             color: Colors.amber,
        //           ),
        //         ),
        //         onDismissed: (direction) {
        //           if (direction == DismissDirection.startToEnd) {
        //             // Handle delete action
        //           } else if (direction == DismissDirection.endToStart) {
        //             // Handle archive action
        //           }
        //         },
        //       ),
                  
        //         ),
        //       ),
              
        //     ],
        //   ),
        // )
      ],)
    );
  }
}