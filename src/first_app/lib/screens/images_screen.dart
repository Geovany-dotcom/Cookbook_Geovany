import 'package:flutter/material.dart';

class ImagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images Section'),
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
                'Images Exercises',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Basic Image Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicImageExample()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.image_outlined),
              title: Text('Image from Internet Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageFromInternetExample()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.image_search),
              title: Text('Fade In Image Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FadeInImageExample()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Select an image exercise from the drawer menu'),
      ),
    );
  }
}

class BasicImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Image Example'),
      ),
      body: Center(
        child: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ImageFromInternetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image from Internet Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
              'https://picsum.photos/250?image=9',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Image.network(
              'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class FadeInImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fade In Image Example'),
      ),
      body: Stack(
        children: <Widget>[
          const Center(child: CircularProgressIndicator()),
          Center(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.png', // Asegúrate de tener esta imagen en tu proyecto
              image: 'https://picsum.photos/250?image=9',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
