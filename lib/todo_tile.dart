import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile(
      {Key? key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
        required this.deleteFunction
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25,left: 25,right: 25),
        child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(onPressed: deleteFunction,
            icon: Icons.delete,
              backgroundColor: Colors.greenAccent,
              borderRadius: BorderRadius.circular(5),
            )
          ]),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Text(taskName,style: TextStyle(fontSize: 18,color: Colors.black,decoration: taskCompleted==true?TextDecoration.lineThrough:TextDecoration.none),),
                Spacer(),
                Checkbox(value: taskCompleted, onChanged: onChanged,activeColor: Colors.black,),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.redAccent.shade200.withOpacity(0.6), borderRadius: BorderRadius.circular(10)),
          ),
        ),
      );
  }
}
