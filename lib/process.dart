class Process {
  int pid;
  String duration;
  String datname;
  String query;

  Process(int pid, String duration, String datname, String query) {
    this.pid = pid;
    this.duration = duration;
    this.datname = datname;
    this.query = query;
  }
}