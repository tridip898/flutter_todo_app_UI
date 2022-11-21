import 'package:flutter/material.dart';
import 'package:todo_app/database.dart';
import 'package:todo_app/todo_tile.dart';
import 'DialogBox.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox=Hive.box('myBox');
  ToDoDatabase db=ToDoDatabase();

  @override
  void initState() {
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }

    super.initState();
  }

  final _controller=TextEditingController();

  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
    });
    db.updateData();
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.pop(context);
    db.updateData();
  }
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel:()=> Navigator.of(context).pop(),
      );
    });
  }

  void deleteTask(int index){
    db.toDoList.removeAt(index);
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: Icon(Icons.menu,size: 35,color: Colors.white,),
          title: Text("To Do",style: TextStyle(fontSize: 30,fontFamily: "Times New Roman",color: Colors.white,),),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.purple.shade400,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,size: 30,color: Colors.white,))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.pinkAccent,
          child: Icon(Icons.add,size: 35,),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context,index){
            return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value)=>checkBoxChanged(value,index),
              deleteFunction: (context)=>deleteTask(index),
            );
          },
        ),
      ),
    );
  }
}
