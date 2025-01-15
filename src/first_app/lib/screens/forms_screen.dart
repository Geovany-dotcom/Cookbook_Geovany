import 'package:flutter/material.dart';

class FormsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms Section'),
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
                'Forms Exercises',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Form Validation Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormValidationExample()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('Text Field Styling Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextFieldStylingExample()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.keyboard),
              title: Text('Focus and Text Fields Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FocusAndTextFieldsExample()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.change_circle),
              title: Text('Handle Text Changes Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HandleTextChangesExample()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.text_snippet),
              title: Text('Retrieve Text Value Example'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RetrieveTextValueExample()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Select a form exercise from the drawer menu'),
      ),
    );
  }
}

class FormValidationExample extends StatefulWidget {
  @override
  _FormValidationExampleState createState() => _FormValidationExampleState();
}

class _FormValidationExampleState extends State<FormValidationExample> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your text here',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldStylingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Field Styling Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FocusAndTextFieldsExample extends StatefulWidget {
  @override
  _FocusAndTextFieldsExampleState createState() => _FocusAndTextFieldsExampleState();
}

class _FocusAndTextFieldsExampleState extends State<FocusAndTextFieldsExample> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus and Text Fields Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Autofocus Text Field',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              focusNode: myFocusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tap the button to focus',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                myFocusNode.requestFocus();
              },
              child: Text('Focus the Text Field'),
            ),
          ],
        ),
      ),
    );
  }
}

class HandleTextChangesExample extends StatefulWidget {
  @override
  _HandleTextChangesExampleState createState() => _HandleTextChangesExampleState();
}

class _HandleTextChangesExampleState extends State<HandleTextChangesExample> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Text field value: $text (${text.characters.length} characters)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Handle Text Changes Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Start typing...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RetrieveTextValueExample extends StatefulWidget {
  @override
  _RetrieveTextValueExampleState createState() => _RetrieveTextValueExampleState();
}

class _RetrieveTextValueExampleState extends State<RetrieveTextValueExample> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Value Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter some text',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(myController.text),
                    );
                  },
                );
              },
              child: Text('Show me the value!'),
            ),
          ],
        ),
      ),
    );
  }
}
