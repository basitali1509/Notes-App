import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Controller/display_notes_provider.dart';
import 'package:notes_app/Model/db_helper.dart';
import 'package:notes_app/Model/db_model.dart';
import 'package:notes_app/View/add_notes.dart';
import 'package:notes_app/View/view_notes.dart';
import 'package:provider/provider.dart';

class DisplayNotes extends StatefulWidget {
  const DisplayNotes({Key? key}) : super(key: key);

  @override
  State<DisplayNotes> createState() => _DisplayNotesState();
}

class _DisplayNotesState extends State<DisplayNotes> {
  DatabaseHelper? databaseHelper;
  late Future<List<Notes>> notesList;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    databaseHelper = DatabaseHelper();
    loadData();
  }

  loadData() async {
    notesList = databaseHelper!.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Consumer<DisplayNotesProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      value.addFilter('all');
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.withOpacity(.65)),
                      child: const Center(
                          child: Icon(Icons.filter_alt,
                              color: Colors.red, size: 26)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.addFilter('high');
                    },
                    child: Container(
                      height: size.height * 0.043,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey.withOpacity(.65)),
                      child: const Center(
                          child: Text(
                        'High',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.addFilter('medium');
                    },
                    child: Container(
                      height: size.height * 0.043,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey.withOpacity(.65)),
                      child: const Center(
                          child: Text(
                        'Medium',
                        style: TextStyle(fontSize: 18, color: Colors.yellow),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.addFilter('low');
                    },
                    child: Container(
                      height: size.height * 0.042,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey.withOpacity(.65)),
                      child: const Center(
                          child: Text(
                        'Low',
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      )),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          Consumer<DisplayNotesProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Expanded(
                  child: FutureBuilder(
                      future: notesList,
                      builder: (context, AsyncSnapshot<List<Notes>> snapshot) {
                        if (snapshot.hasData) {
                          List<Notes> filteredNotes = snapshot.data!;
                          if (value.filter == 'high') {
                            filteredNotes = snapshot.data!
                                .where((note) => note.priority == 1)
                                .toList();
                          } else if (value.filter == 'medium') {
                            filteredNotes = snapshot.data!
                                .where((note) => note.priority == 2)
                                .toList();
                          } else if (value.filter == 'low') {
                            filteredNotes = snapshot.data!
                                .where((note) => note.priority == 3)
                                .toList();
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: StaggeredGridView.builder(
                              itemCount: filteredNotes.length,
                              gridDelegate:
                                  SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                staggeredTileCount: filteredNotes.length,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 8,
                                staggeredTileBuilder: (index) =>
                                    const StaggeredTile.fit(1),
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    var now = DateTime.now();
                                    var formatter = DateFormat('dd-MM-yyyy');
                                    String formattedDate =
                                        formatter.format(now);

                                    List<Notes>? snapData = filteredNotes;
                                    final data = Notes(
                                      id: filteredNotes[index].id,
                                      title:
                                          filteredNotes[index].title.toString(),
                                      subtitle: filteredNotes[index]
                                          .subtitle
                                          .toString(),
                                      description: filteredNotes[index]
                                          .description
                                          .toString(),
                                      priority: filteredNotes[index].priority,
                                      date: formattedDate,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewNotes(
                                            snap: snapData,
                                            notes: notesList,
                                            noteslist: data),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.grey.withOpacity(.65),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                filteredNotes[index]
                                                    .title
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 8,
                                                backgroundColor:
                                                    filteredNotes[index]
                                                                .priority ==
                                                            1
                                                        ? Colors.red
                                                        : filteredNotes[index]
                                                                    .priority ==
                                                                2
                                                            ? Colors.yellow
                                                            : Colors.green,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              filteredNotes[index]
                                                  .subtitle
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFFD1D1D1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              filteredNotes[index].date,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNotes(
                        noteslist: notesList,
                      )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
