import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Widgets Demo',
      routes: {
        '/actions': (_) => ActionsPage(),
        '/communication': (_) => CommunicationPage(),
        '/containment': (_) => ContainmentPage(),
        '/navigation': (_) => NavigationPage(),
        '/selection': (_) => SelectionPage(),
        '/input': (_) => InputPage(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List pages = [
      ['Actions', '/actions'],
      ['Communication', '/communication'],
      ['Containment', '/containment'],
      ['Navigation', '/navigation'],
      ['Selection', '/selection'],
      ['Text Input', '/input'],
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Material Components")),
      body: ListView(
        children: pages.map((p) {
          return ListTile(
            title: Text(p[0]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, p[1]),
          );
        }).toList(),
      ),
    );
  }
}

Widget codeBox(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.only(top: 20),
    color: Colors.black12,
    child: Text(code),
  );
}

/* ================= Actions ================= */

class ActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String code = '''
ElevatedButton(
  onPressed: () {},
  child: Text("Press"),
);
''';

    return Scaffold(
      appBar: AppBar(title: Text("Actions")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Press")),
            codeBox(code),
          ],
        ),
      ),
    );
  }
}

/* ================= Communication ================= */

class CommunicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String code = '''
ScaffoldMessenger.of(context)
.showSnackBar(SnackBar(content: Text("Saved")));
''';

    return Scaffold(
      appBar: AppBar(title: Text("Communication")),
      body: Center(
        child: ElevatedButton(
          child: Text("Show SnackBar"),
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Saved")));
          },
        ),
      ),
      bottomSheet: codeBox(code),
    );
  }
}

/* ================= Containment ================= */

class ContainmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String code = '''
Card(
 child: ListTile(title: Text("Flutter")),
);
''';

    return Scaffold(
      appBar: AppBar(title: Text("Containment")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(child: ListTile(title: Text("Flutter Card"))),
            codeBox(code),
          ],
        ),
      ),
    );
  }
}

/* ================= Navigation ================= */

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String code = '''
Navigator.pushNamed(context, '/actions');
''';

    return Scaffold(
      appBar: AppBar(title: Text("Navigation")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Go Actions"),
              onPressed: () {
                Navigator.pushNamed(context, '/actions');
              },
            ),
            codeBox(code),
          ],
        ),
      ),
    );
  }
}

/* ================= Selection ================= */

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    String code = '''
Checkbox(
 value: checked,
 onChanged: (v){},
);
''';

    return Scaffold(
      appBar: AppBar(title: Text("Selection")),
      body: Column(
        children: [
          Checkbox(
            value: checked,
            onChanged: (v) {
              setState(() {
                checked = v!;
              });
            },
          ),
          codeBox(code),
        ],
      ),
    );
  }
}

/* ================= Text Input ================= */

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String code = '''
TextField(
 decoration: InputDecoration(labelText: "Name"),
);
''';

    return Scaffold(
      appBar: AppBar(title: Text("Text Input")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Enter name")),
            codeBox(code),
          ],
        ),
      ),
    );
  }
}
