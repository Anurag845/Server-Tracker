import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:server_tracker/server.dart';
import 'dart:convert';

import 'process.dart';
import 'processes.dart';

class Servers extends StatefulWidget {
  @override
  _ServersState createState() => _ServersState();
}

class _ServersState extends State<Servers> {

  bool isData = false;
  List data = List();
  int totact = 0;
  int highcnt = 0;
  Set<String> servers = Set<String>();
  List<Server> srvs = List<Server>();
  List<Process> highpro = List<Process>();

  _retrieve() async {
    var response = await http.post("http://192.168.43.18/Server_Tracker/servers.php");
    
    if(response.statusCode == 200) {
      data = json.decode(response.body);
      totact = data.length;
      isData = true;
      for(int i = 0; i < totact; i++) {
        String ip = data[i]["hostname"];
        if(!servers.contains(ip)) {
          servers.add(ip);
          int cnt = 0;
          List<Process> pro = List<Process>();
          List<String> dur = List<String>();
          for(int j = 0; j < totact; j++) {
            if(data[j]["hostname"] == ip) {
              cnt++;
              pro.add(new Process(data[j]["pid"],data[j]["duration"],data[j]["datname"],data[j]["?column?"]));
              String d = data[j]["duration"];
              dur.add(d);
            }
          }
          String duration = data[i]["duration"];
          List<String> parts = duration.split(":");
          double seconds = 0;
          if(parts.length > 2) {
            seconds = double.parse(parts[2]);
            if(seconds > 2) {
              highcnt++;
              highpro.add(new Process(data[i]["pid"],data[i]["duration"],data[i]["datname"],data[i]["?column?"]));
            }
          }
          dur.sort((a,b) => a.compareTo(b));
          srvs.add(new Server(ip,cnt,dur.first,dur.last,pro));
        }
      }
      setState(() {
        print("Data Received");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _retrieve();
  }

  serverPage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("Total Active queries: " + totact.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
            child: Text("Highest Queries: " + highcnt.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Processes(hostname: "", processes: highpro),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: srvs == null ? 0 : srvs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Processes(hostname: srvs[index].hostname, processes: srvs[index].processes),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(srvs[index].hostname),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(srvs[index].numofpro.toString()),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Text(srvs[index].min),
                              Text("to"),
                              Text(srvs[index].max),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              );
            }
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servers"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.all(5),
            icon: Icon(
              Icons.autorenew,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _retrieve();
              });
            }
          ),
        ],
      ),
      body: !isData ? new Center(
              child: new CircularProgressIndicator(),
            )
          : serverPage(),
    );
  }
}