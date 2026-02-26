import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/note_repository.dart';
import 'ui/home_page.dart';
import 'ui/state/note_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NoteRepository>(
          create: (_) => NoteRepository(),
        ),
        ChangeNotifierProvider<NoteStore>(
          create: (context) =>
              NoteStore(context.read<NoteRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter SQLite Notes',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
          ),
          scaffoldBackgroundColor: Colors.grey.shade100,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          cardTheme: CardThemeData(
            elevation: 3,
            color: Colors.indigo.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}