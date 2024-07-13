import 'package:flutter/material.dart';
import '../../app/Models/Note.dart';
import '../../../app/Controllers/NoteController.dart';

class NoteWidget extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const NoteWidget({
    super.key,
    required this.note,
    required this.onTap,
    required this.onLongPress
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  late int isFav = widget.note.favourite;

  @override
  void initState() {
    super.initState();
  }

  void _toggleFavorite() {
    setState(() {
      if(isFav == 1) {
        isFav = 0;
        DatabaseHelper.favouriteNote(widget.note, 0);
      } else {
        isFav = 1;
        DatabaseHelper.favouriteNote(widget.note, 1);
      }
    });
  }

  Widget favouriteButton(){
    return ListTile(
      trailing: IconButton(
        iconSize: 30,
        icon: Icon(
          Icons.favorite,
          color: isFav == 1 ? Colors.redAccent : Colors.grey,
        ), onPressed: (){_toggleFavorite();}
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [Text(
                                    widget.note.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                )],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [favouriteButton()],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(
                  widget.note.description,
                  style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.w400
                  )
                ),
                Text(
                  widget.note.complete == 1 ? 'Completed' : '',
                  style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.w400
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}