import 'package:flutter/material.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

class ListScreen extends StatelessWidget {
  final List<ListItem> items = List<ListItem>.generate(
    100,
        (i) => i % 6 == 0
        ? HeadingItem('Heading $i')
        : MessageItem('Sender $i', 'Message body $i'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Examples'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Exercises Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.grid_view),
              title: Text('Grid List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GridListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Horizontal List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HorizontalListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Different Types of Items'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DifferentTypesListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.view_agenda),
              title: Text('Floating App Bar List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FloatingAppBarListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Static List Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StaticListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_numbered),
              title: Text('Long List Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LongListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.space_bar),
              title: Text('Spaced Items List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpacedItemsListScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Select an exercise from the drawer menu'),
      ),
    );
  }
}

class GridListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid List Example'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // 2 columns
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        }),
      ),
    );
  }
}

class HorizontalListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal List Example'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 160,
            color: Colors.red,
          ),
          Container(
            width: 160,
            color: Colors.blue,
          ),
          Container(
            width: 160,
            color: Colors.green,
          ),
          Container(
            width: 160,
            color: Colors.yellow,
          ),
          Container(
            width: 160,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class DifferentTypesListScreen extends StatelessWidget {
  final List<ListItem> items = List<ListItem>.generate(
    100,
        (i) => i % 6 == 0
        ? HeadingItem('Heading $i')
        : MessageItem('Sender $i', 'Message body $i'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Different Types of Items'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
          );
        },
      ),
    );
  }
}

class FloatingAppBarListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Floating App Bar'),
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Expanded Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                title: Text('Item #$index'),
              ),
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}

class StaticListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Static List Example'),
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Album'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          ),
        ],
      ),
    );
  }
}

class LongListScreen extends StatelessWidget {
  final List<String> items = List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Long List Example'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        prototypeItem: ListTile(
          title: Text(items.first),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}

class SpacedItemsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spaced Items List'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ItemWidget(text: 'Item 1'),
                  ItemWidget(text: 'Item 2'),
                  ItemWidget(text: 'Item 3'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String text;

  ItemWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
