import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dio/dio.dart';

const String apiUrl = 'https://crudcrud.com/api/a1bc81965809454f94e3787098489cff/users';

class NetworkHomePage extends StatefulWidget {
  const NetworkHomePage({super.key});

  @override
  State<NetworkHomePage> createState() => _NetworkHomePageState();
}

class _NetworkHomePageState extends State<NetworkHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const WebSocketPage(),
    const FetchDataPage(),
    const SendDataPage(),
    const DeleteDataPage(),
    const UpdateDataPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Tasks with WebSocket'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Network Tasks',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('WebSocket'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Fetch Data'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Send Data'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Delete Data'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Update Data'),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WebSocketPage extends StatelessWidget {
  const WebSocketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
    );

    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(snapshot.hasData
                      ? 'Received: ${snapshot.data}'
                      : 'Waiting for data...'),
                );
              },
            ),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Send a message',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                channel.sink.add(text);
                textController.clear();
              },
            ),
            ElevatedButton(
              onPressed: () {
                channel.sink.add('Hello WebSocket!');
              },
              child: const Text('Send Hello'),
            ),
          ],
        ),
      ),
    );
  }
}

class FetchDataPage extends StatelessWidget {
  const FetchDataPage({super.key});

  Future<List<dynamic>> fetchUsers() async {
    final dio = Dio();
    final response = await dio.get(apiUrl);
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fetch Data')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index]['name']),
                  subtitle: Text('ID: ${users[index]['_id']} | Age: ${users[index]['age']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class SendDataPage extends StatelessWidget {
  const SendDataPage({super.key});

  Future<void> sendUser(BuildContext context, String name, int age) async {
    final dio = Dio();
    try {
      final response = await dio.post(apiUrl, data: {
        'name': name,
        'age': age,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User created: ${response.data}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Send Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final age = int.tryParse(ageController.text);
                if (name.isNotEmpty && age != null) {
                  sendUser(context, name, age);
                }
              },
              child: const Text('Send Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteDataPage extends StatelessWidget {
  const DeleteDataPage({super.key});

  Future<void> deleteUser(BuildContext context, String id) async {
    final dio = Dio();
    try {
      await dio.delete('$apiUrl/$id');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User $id deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Delete Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Enter User ID'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final id = idController.text;
                if (id.isNotEmpty) {
                  deleteUser(context, id);
                }
              },
              child: const Text('Delete Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateDataPage extends StatelessWidget {
  const UpdateDataPage({super.key});

  Future<void> updateUser(BuildContext context, String id, String name, int age) async {
    final dio = Dio();
    try {
      final response = await dio.put('$apiUrl/$id', data: {
        'name': name,
        'age': age,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User updated: ${response.data}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Update Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Enter User ID'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final id = idController.text;
                final name = nameController.text;
                final age = int.tryParse(ageController.text);
                if (id.isNotEmpty && name.isNotEmpty && age != null) {
                  updateUser(context, id, name, age);
                }
              },
              child: const Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
