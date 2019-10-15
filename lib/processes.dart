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
              return Card(
                child: Wrap(
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