import 'package:flutter/material.dart';
import 'package:reminder/main.dart';
import 'package:reminder/model/data_model.dart';
import 'package:reminder/screen/editscreen.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  void initState() {
    super.initState();
    eventlist.getAllEvent(); // You may need to load your events initially.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ValueListenableBuilder<List<EventModel>>(
                valueListenable: eventlist.eventListNotifier,
                builder: (BuildContext ctx, List<EventModel> eventList, Widget? child) {
                  if (eventList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Such data!",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    );
                  }
                  return ListView.separated(
                    reverse: false,
                    itemBuilder: (ctx, index) {
                      final data = eventList[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(data.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                          subtitle: Text(
                              '${data.dateTime.day}/${data.dateTime.month}/${data.dateTime.year}',style: const TextStyle(color: Colors.blueGrey),),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: TextButton(
                                        onPressed: () {
                                          // to edit
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => EditScreen(
                                                name: data.title,
                                                select: data.catogory,
                                                dates: data.dateTime,
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text("Edit"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:const EdgeInsets.only(left: 10),
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Just for a conformation"),
                                                content: const Text("Are you sure to delete the item"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        eventlist.deleteEvents(index);
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text("Ok"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert_rounded),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: eventList.length > 4 ? 4 : eventList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
