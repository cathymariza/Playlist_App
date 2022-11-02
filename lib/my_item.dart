import 'package:flutter/material.dart';
import 'NewButton.dart';
import 'main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Item {
  const Item({required this.name, required this.ssubtitle});

  final String name;
  final String ssubtitle;

  String abbrev() {
    return name.substring(0, 1);
  }
}


typedef MySongChangedCallback = Function(Item song , bool saved
);
typedef MySongRemovedCallback = Function(Item song);

/*class MySongItem extends StatelessWidget {
  ToDoListItem(
      {required this.item,
      //required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));

  final Item item;
  final bool completed;
  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
        ? Colors.black
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(item, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteItem(item);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(item.abbrev()),
      ),
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
      trailing: Icon(Icons.favorite_border),
      
      );
  }
}*/
class MySongItem extends StatelessWidget {
  MySongItem(
    {
      required this.song,
      required this.saved,
      required this.onListTapped,
      required this.onDeleteItem,
    }) : super(key: ObjectKey(song));

    final Item song;
    final bool saved;
    final MySongChangedCallback onListTapped;
    final MySongRemovedCallback onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () {
        onListTapped(song, saved);
      },
      onLongPress: () {
        onDeleteItem(song);
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(song.name[0].toUpperCase()),
      ),
      title: Text(
        song.name,
      ),
      subtitle: Text(song.ssubtitle),
      trailing: Icon(
        saved ? Icons.favorite: Icons.favorite_border,
        color: saved ? Colors.red : null,
        )
    ));

    
  }
}
