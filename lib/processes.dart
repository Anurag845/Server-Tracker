import 'package:flutter/material.dart';
import 'process.dart';

class Processes extends StatefulWidget {
  final String hostname;
  final List<Process> processes;
  Processes({Key key, @required this.hostname, @required this.processes}) : super(key: key);
  @override
  _ProcessesState createState() => _ProcessesState();
}

class _ProcessesState extends State<Processes> {

  void _showDialog() {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Terminate?"),
          content: new Text("Are you sure you want to terminate this process?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  processPage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(widget.hostname),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.processes.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onLongPress: () {
                    _showDialog();
                  },
                  child: Card(
                    elevation: 5,
                    child: ExpansionTile(
                      title: Wrap(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Text("PID"),
                                Text(widget.processes[index].pid.toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(widget.processes[index].datname),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Text("Duration"),
                                Text(widget.processes[index].duration),
                              ],
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text("Query"),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(widget.processes[index].query),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              );
            },
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Processes"),
        backgroundColor: Colors.black,
      ),
      body: processPage(),
    );
  }
}