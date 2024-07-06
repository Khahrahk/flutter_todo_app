class Note{
  final int? id;
  final String title;
  final String description;
  final int complete;
  final int softDelete;

  const Note({this.id, required this.title, required this.description, this.complete = 0, this.softDelete = 0});

  factory Note.fromJson(Map<String,dynamic> json) => Note(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    complete: json['complete'],
    softDelete: json['softDelete']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'complete': complete,
    'softDelete': softDelete
  };
}