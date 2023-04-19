import 'package:flutter/material.dart';
import 'package:notes_app/Controller/delete_notes_provider.dart';
import 'package:notes_app/Model/db_helper.dart';
import 'package:notes_app/Model/db_model.dart';
import 'package:notes_app/Utils/snackbar.dart';
import 'package:notes_app/View/edit_notes.dart';
import 'package:notes_app/View/notes_display.dart';
import 'package:provider/provider.dart';

class ViewNotes extends StatefulWidget {
  List<Notes>? snap;
  Future<List<Notes>> notes;
  Notes noteslist;
  ViewNotes(
      {required this.snap,
      required this.notes,
      required this.noteslist,
      Key? key})
      : super(key: key);

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  DatabaseHelper? databaseHelper;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
         Consumer<DeleteNotesProvider>(builder: (BuildContext context, value, Widget? child) {
           return  IconButton(
               onPressed: () async {
                 // setState(() {
                 //   databaseHelper!.delete(widget.noteslist.id!);
                 //   widget.notes = databaseHelper!.getNotes();
                 //   //widget.snap!.remove(widget.noteslist.id);
                 // });
                 print('inside icon');
                 value.deleteNotes(databaseHelper!, widget.noteslist.id!);
                 snackBar.showSnackBar(context, 'Deleted Successfully');
                 await Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                         builder: (context) => const DisplayNotes()));
               },
               icon: const Icon(Icons.delete));
         },),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNotes(
                            notes: widget.notes,
                            noteslist: widget.noteslist)));
                // setState(() {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => EditNotes(
                //               notes: widget.notes,
                //               noteslist: widget.noteslist)));
                // });
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.65),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  widget.noteslist.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.65),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  child: Text(
                    widget.noteslist.subtitle,
                    style: const TextStyle(fontSize: 16),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 10,
                    backgroundColor: widget.noteslist.priority == 1
                        ? Colors.red
                        : widget.noteslist.priority == 2
                            ? Colors.yellow
                            : Colors.green)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              height: 270,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.65),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  child: Text(
                    widget.noteslist.description,
                    style: const TextStyle(fontSize: 15),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
