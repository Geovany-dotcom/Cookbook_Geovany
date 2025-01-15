import 'package:flutter/material.dart';

void main() => runApp(DesignScreen());

class DesignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design with Theme',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontFamily: 'Arial',
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Design Section'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Drawer Header',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.grid_view),
              title: Text('Orientation Grid'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrientationGridPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.tab),
              title: Text('Tabs Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabsExamplePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('SnackBar Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SnackBarExamplePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Select an option from the menu',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class OrientationGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientation Grid'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: List.generate(20, (index) {
              return Card(
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class TabsExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tabs Example'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car), text: 'Car'),
              Tab(icon: Icon(Icons.directions_transit), text: 'Transit'),
              Tab(icon: Icon(Icons.directions_bike), text: 'Bike'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Icon(Icons.directions_car, size: 50)),
            Center(child: Icon(Icons.directions_transit, size: 50)),
            Center(child: Icon(Icons.directions_bike, size: 50)),
          ],
        ),
      ),
    );
  }
}

class SnackBarExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SnackBar Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('Yay! A SnackBar!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Código para deshacer la acción.
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Text('Show SnackBar'),
        ),
      ),
    );
  }
}
