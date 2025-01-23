import 'package:flutter/material.dart';
import '../screens/design_screen.dart';
import '../screens/list_screen.dart';
import '../screens/forms_screen.dart';
import '../screens/images_screen.dart';
import '../screens/navigation_screen.dart';
import '../screens/animation_screen.dart';
import '../screens/network_screen.dart';
import '../screens/localstore_screen.dart';

class HomeScreen extends StatelessWidget {
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.design_services,
                color: Colors.blue,
                title: 'Go to Design Section',
                screen: DesignScreen(),
              ),
              _buildMenuItem(
                context,
                icon: Icons.list,
                color: Colors.green,
                title: 'Go to List Section',
                screen: ListScreen(),
              ),
              _buildMenuItem(
                context,
                icon: Icons.edit,
                color: Colors.orange,
                title: 'Go to Forms Section',
                screen: FormsScreen(),
              ),
              _buildMenuItem(
                context,
                icon: Icons.image,
                color: Colors.purple,
                title: 'Go to Images Section',
                screen: ImagesScreen(),
              ),
              _buildMenuItem(
                context,
                icon: Icons.navigation,
                color: Colors.red,
                title: 'Go to Navigation Section',
                screen: NavigationScreen(),
              ),
              _buildMenuItem(
                context,
                icon: Icons.animation,
                color: Colors.teal,
                title: 'Go to Animation Section',
                screen: AnimationHomePage(),
              ),
              _buildMenuItem(
                context,
                icon: Icons.network_cell,
                color: Colors.blueGrey,
                title: 'Go to Network Section',
                screen: NetworkHomePage(),
              ),
              _buildMenuItem(
                context,
                icon: Icons.storage,
                color: Colors.deepOrange,
                title: 'Go to Local Storage Section',
                screen: LocalStoreScreen(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required String title,
        required Widget screen,
      }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Cookbook'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido a la pochocloApp',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shadowColor: Colors.black,
                  elevation: 8,
                ),
                onPressed: () => _showMenu(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.menu, color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'Open Menu',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
