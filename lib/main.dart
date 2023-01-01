import 'package:flutter/material.dart';
import 'package:flutter_todolist/screens/notes_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const StartPage());
class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.caudexTextTheme()),
        home: const MyApp());
  }
}
