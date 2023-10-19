import 'package:flutter/material.dart';
//import 'package:reminder/functions/events_db.dart';
import 'package:reminder/main.dart';
import 'package:reminder/model/data_model.dart';
import 'package:reminder/screen/editscreen.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    eventlist.getAllEvent(); // You may need to load your events initially.
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: eventlist.eventListNotifier,
                builder: (BuildContext ctx, List<EventModel> eventlist, Widget? child) {
                  if (eventlist.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Such data!",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    );
                  }
                  return EventListView(eventList: eventlist);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventListView extends StatefulWidget {
  final List<EventModel> eventList;

  const EventListView({super.key, required this.eventList});

  @override
  State<EventListView> createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: false,
      itemBuilder: (ctx, index) {
        final data = widget.eventList[index];
        return Card(
          elevation: 2,
          child: ListTile(
            title: Text(data.title),
            subtitle: Text(
                '${data.dateTime.day}/${data.dateTime.month}/${data.dateTime.year}'),
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
                                builder: (context) =>
                                     EditScreen(name: data.title, select: data.catogory,dates: data.dateTime,index: index,),
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
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextButton(
                          onPressed: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text("Just for a conformation"),
                                content: const Text("Are you sure to delete the item"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: const Text("Cancel"),),
                                  TextButton(onPressed: (){
                                    setState(() {
                                      eventlist.deleteEvents(index);
                                    });
                                    Navigator.of(context).pop();
                                  }, child: const Text("Ok"),),
                                ],
                              );
                            });
                            // Navigator.of(context).pop();
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
      itemCount: widget.eventList.length > 4 ? 4: widget.eventList.length,
    );
  }
}
