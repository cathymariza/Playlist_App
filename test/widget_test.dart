// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/NewButton.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/my_item.dart';

void main() {
  test('Item abbreviation should be first letter', () {
    const item =
        Item(name: "add a new song", ssubtitle: "add the artist's name");
    expect(item.abbrev(), "a");
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: MySongItem(
                song: const Item(name: "test", ssubtitle: 'testartist'),
                saved: true,
                onListTapped: (Item song, bool saved) {},
                onDeleteItem: (Item name) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('ToDoListItem has a Circle Avatar with abbreviation',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: MySongItem(
                song: const Item(name: "test", ssubtitle: 'testartist'),
                saved: true,
                onListTapped: (Item song, bool saved) {},
                onDeleteItem: (Item song) {}))));
    final abbvFinder = find.text('t');
    final avatarFinder = find.byType(CircleAvatar);

    CircleAvatar circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(abbvFinder, findsOneWidget);
    expect(circ.backgroundColor, Colors.black);
    expect(ctext.data, "t");
  });

  testWidgets('Default ToDoList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MySong()));

    final listItemFinder = find.byType(MySongItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MySong()));

    expect(find.byType(TextField), findsNothing);
    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(NewButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    final listItemFinder = find.byType(MySongItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  testWidgets('Test presence of iconButtons', (tester) async {
    final searchiconbutton = find.byKey(const ValueKey("searchicon"));
    await tester.pumpWidget(const MaterialApp(home: MySong()));
    expect(find.byKey(Key("searchicon")), findsOneWidget);
    expect(find.byKey(Key("homeicon")), findsOneWidget);
    expect(find.byKey(Key("settingsicon")), findsOneWidget);
  });

  // One to test the tap and press actions on the items?
}
