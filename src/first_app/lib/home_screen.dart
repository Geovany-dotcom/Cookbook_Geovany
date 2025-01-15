import 'package:flutter/material.dart';
import '../screens/design_screen.dart';
import '../screens/list_screen.dart';
import '../screens/forms_screen.dart';
import '../screens/images_screen.dart';
import '../screens/navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.design_services, color: Colors.blue),
                title: Text('Go to Design Section'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DesignScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list, color: Colors.green),
                title: Text('Go to List Section'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.orange),
                title: Text('Go to Forms Section'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormsScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: Colors.purple),
                title: Text('Go to Images Section'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImagesScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.navigation, color: Colors.red),
                title: Text('Go to Navigation Section'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Flutter Cookbook!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () => _showMenu(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu),
                  SizedBox(width: 8),
                  Text(
                    'Open Menu',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

