// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_dont_list/NewButton.dart';
import 'package:to_dont_list/my_item.dart';
//import 'package:to_dont_list/to_do_items.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

List<String> songs = [];

class MySong extends StatefulWidget {
  const MySong({super.key});

  @override
  State createState() => _MySongState();
}

class _MySongState extends State<MySong> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.red);
  final ButtonStyle myStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.blue);

  //get actions => null;

  Future<void> _displayTextInputDialog(BuildContext context) async {
    print("Loading Dialog");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Item To Add'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                  },
                  controller: _inputController,
                  decoration: const InputDecoration(hintText: "type song here"),
                ),
                TextField(
                  onChanged: (subttitle) {
                    setState(() {
                      itstext = subttitle;
                    });
                  },
                  controller: _subtitleController,
                  decoration: const InputDecoration(hintText: "type link here"),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                key: const Key("OKButton"),
                style: yesStyle,
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    _handleNewItem(valueText, itstext);
                    Navigator.pop(context);
                  });
                },
              ),
              // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _inputController,
                builder: (context, value, child) {
                  return ElevatedButton(
                    key: const Key("CancelButton"),
                    style: noStyle,
                    onPressed: value.text.isNotEmpty
                        ? () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          }
                        : null,
                    child: const Text('Cancel'),
                  );
                },
              ),
            ],
          );
        });
  }

  String valueText = "";
  String itstext = "";

  //final List<Item> items = [const Item(name: "Add a new song", ssubtitle: "Add song link")];
  final List<Item> items = [];
  final _itemSet = <Item>{};
  Set<String> savedsongs = Set<String>();

  void _handleListChanged(Item song, bool saved) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(song);
      if (!saved) {
        print("Completing");
        _itemSet.add(song);
        items.add(song);
      } else {
        print("Making Undone");
        _itemSet.remove(song);
        items.insert(0, song);
      }
    });
  }

  void _handleDeleteItem(Item song) {
    setState(() {
      print("Deleting item");
      items.remove(song);
    });
  }

  void _handleNewItem(String valueText, String itstext) {
    setState(() {
      print("Adding new item");
      Item song = Item(name: valueText, ssubtitle: itstext);
      items.insert(0, song);
      songs.add(song.name);
      _inputController.clear();
      _subtitleController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Better get this done'),
          backgroundColor: Colors.blueGrey,
          //home: MyStatefulWidget()
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((name) {
            return MySongItem(
              saved: _itemSet.contains(name),
              onDeleteItem: _handleDeleteItem,
              onListTapped: _handleListChanged, song: name,
              //onListTapped: _handleNewItem,
            );
          }).toList(),

          //child:
        ),
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: IconButton(
                  key: Key("homeicon"),
                  onPressed: () {},
                  icon: Icon(Icons.home),
                  color: Colors.blue),
            ),
            Expanded(
              child: IconButton(
                key: Key("searchicon"),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: MySearchDelegate(),
                      useRootNavigator: true);
                },
                icon: Icon(Icons.search),
                color: Colors.amberAccent,
              ),
            ),
            Expanded(
                child: IconButton(
              key: Key("settingsicon"),
              onPressed: () {},
              icon: Icon(Icons.settings),
              color: Colors.grey,
            )),
          ],
        ),
        // bottomNavigationBar: const GNav(
        //   backgroundColor: Colors.blueGrey,
        //   tabs: [
        //     GButton(
        //       icon: Icons.home,
        //       text: 'Home',
        //       iconColor: Colors.blue,
        //       //textStyle: null,
        //     ),
        //     GButton(
        //       icon: Icons.search,
        //       onPressed: () {
        //         showSearch(context: context, delegate: MySearchDelegate())
        //       },
        //       text: 'Search',
        //       iconColor: Colors.amberAccent,
        //     ),
        //     GButton(
        //       icon: Icons.settings,
        //       text: 'Settings',
        //       iconColor: Colors.grey,
        //     ),
        //   ],
        // )
        // //BottomAppBar(
        // //shape: const CircularNotchedRectangle(),
        // //child: Container(height: 50.0),

        // //_displayTextInputDialog(BuildContext context) async {
        // //print("Loading Dialog");
        // //return showDialog(

        // //child: Container(height: 50.0),
        // ,
        floatingActionButton: NewButton(
            //child: const Icon(Icons.add),
            onPressed: () {
          _displayTextInputDialog(context);
        }));
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = songs;

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];
  @override
  Widget buildResults(BuildContext context) => Center(
      child:
          Text(key: Key('text1'), query, style: const TextStyle(fontSize: 30)));
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;

            showResults(context);
          },
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Playlist App',
    home: MySong(),
  ));
}
