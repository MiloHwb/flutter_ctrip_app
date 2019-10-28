import 'package:flutter/material.dart';

class Choice {
  final String title;
  final IconData icon;

  const Choice(this.title, this.icon);
}

const List<Choice> choices = [
  const Choice('CAR', Icons.directions_car),
  const Choice('BICYCLE', Icons.directions_bike),
  const Choice('BOAT', Icons.directions_boat),
  const Choice('BUS', Icons.directions_bus),
  const Choice('TRAIN', Icons.directions_railway),
  const Choice('WALK', Icons.directions_walk),
];

class TabbedAppBarSample extends StatelessWidget {
  TabbedAppBarSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tabbed AppBar'),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
              children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ChoiceCard(choice: choice),
            );
          }).toList()),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final Choice choice;

  ChoiceCard({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 128,
              color: textStyle.color,
            ),
            Text(
              choice.title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
