import 'process.dart';

class Server {
  String hostname;
  int numofpro;
  String min;
  String max;
  List<Process> processes;

  Server(String hostname, int numofpro, String min, String max, List<Process> processes) {
    this.hostname = hostname;
    this.numofpro = numofpro;
    this.min = min;
    this.max = max;
    this.processes = processes;
  }
}