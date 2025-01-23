import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStoreScreen extends StatefulWidget {
  const LocalStoreScreen({Key? key}) : super(key: key);

  @override
  State<LocalStoreScreen> createState() => _LocalStoreScreenState();
}

class _LocalStoreScreenState extends State<LocalStoreScreen> {
  late Future<Database> database;
  int _counter = 0; // Variable para shared_preferences
  int _fileCounter = 0; // Contador para la funcionalidad de lectura/escritura de archivos
  late CounterStorage _storage;

  @override
  void initState() {
    super.initState();
    _storage = CounterStorage();
    _initializeDatabase();
    _loadCounter(); // Cargar el contador desde shared_preferences
    _loadFileCounter(); // Cargar el contador desde el archivo
  }

  // Inicializar base de datos SQLite
  void _initializeDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertDog(Dog dog) async {
    final db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {});
  }

  Future<List<Dog>> getDogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(
      maps.length,
          (i) => Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      ),
    );
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
    setState(() {});
  }

  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
    setState(() {});
  }

  // Funciones para shared_preferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      prefs.setInt('counter', _counter);
    });
  }

  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = 0;
      prefs.remove('counter');
    });
  }

  // Funciones para lectura/escritura de archivos
  Future<void> _loadFileCounter() async {
    final value = await _storage.readCounter();
    setState(() {
      _fileCounter = value;
    });
  }

  Future<void> _incrementFileCounter() async {
    setState(() {
      _fileCounter++;
    });
    await _storage.writeCounter(_fileCounter);
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final idController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite, Shared Prefs & File Storage Example'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Sección de shared_preferences
              Text(
                'Shared Preferences Counter: $_counter',
                style: const TextStyle(fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment Counter'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    child: const Text('Reset Counter'),
                  ),
                ],
              ),
              const Divider(height: 32, color: Colors.grey),

              // Sección de lectura/escritura de archivos
              Text(
                'File Storage Counter: $_fileCounter',
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: _incrementFileCounter,
                child: const Text('Increment File Counter'),
              ),
              const Divider(height: 32, color: Colors.grey),

              // Sección de SQLite
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Dog Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Dog Age'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final age = int.tryParse(ageController.text);
                  if (name.isNotEmpty && age != null) {
                    insertDog(
                      Dog(id: DateTime.now().millisecondsSinceEpoch, name: name, age: age),
                    );
                  }
                },
                child: const Text('Add Dog'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'Dog ID to Update/Delete'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'New Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'New Age'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final id = int.tryParse(idController.text);
                      final name = nameController.text;
                      final age = int.tryParse(ageController.text);
                      if (id != null && name.isNotEmpty && age != null) {
                        updateDog(Dog(id: id, name: name, age: age));
                      }
                    },
                    child: const Text('Update Dog'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      final id = int.tryParse(idController.text);
                      if (id != null) {
                        deleteDog(id);
                      }
                    },
                    child: const Text('Delete Dog'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Dog>>(
                future: getDogs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No dogs found'));
                  } else {
                    final dogs = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dogs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(dogs[index].name),
                          subtitle: Text('Age: ${dogs[index].age}, ID: ${dogs[index].id}'),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
