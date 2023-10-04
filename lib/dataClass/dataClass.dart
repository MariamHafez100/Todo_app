class Tasks {
  String? id;
  String? title;
  String? decription;
  DateTime? dateTime;
  bool? Done;

  Tasks(
      {this.id = '',
      required this.title,
      required this.decription,
      this.Done = false,
      required this.dateTime});

  Map<String, dynamic> sendToFireBase() {
    // kda 7ta5ud kol dul w trg3hum map f btale kda et7wlt l jison 3shan msh btfhm 8er map
    return {
      'id': id,
      'title': title,
      'description': decription,
      'DateTime': dateTime?.millisecondsSinceEpoch,
      'done': Done,
    };
  }

  Tasks.reciveFromFireBase(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    decription = data['description'];
    //hena 7yrg3ha mn epoch ll datetime el 3ade 3shan kda 3mlnaha kda
    dateTime = DateTime.fromMillisecondsSinceEpoch(data['DateTime']);
    Done = data['done'];
  }
}
