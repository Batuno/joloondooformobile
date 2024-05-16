import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joloondooapp/pages/components/appstate.dart';
import 'package:joloondooapp/pages/drawer/about_us.dart';
import 'package:joloondooapp/pages/drawer/contact_us.dart';
import 'package:joloondooapp/pages/login/login_page.dart';
import 'package:joloondooapp/pages/menu/exam/exam.dart';
import 'package:joloondooapp/pages/menu/exam/exam_tip.dart';
import 'package:joloondooapp/pages/menu/practise/practise.dart';
import 'package:joloondooapp/pages/menu/subject/subjects.dart';
import 'package:joloondooapp/pages/signup/signup_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      // home: const LoginPage(),
      routes: {
        '/': (context) => const LoginPage(),
        '/aboutpage': (context) => const AboutPage(),
        '/contactpage': (context) => const ContactPage(),
        '/subjectspage': (context) => const Subjects(),
        // '/subjectsdetailpage': (context) => const SubjectsDetail(subject: {},),
        '/practisepage': (context) => const Practise(),
        '/register': (context) => const SignUpPage(),
        '/examtippage': (context) => const ExampTip(),
        '/exampage': (context) => ExamPage(questions: const []),
      },
    );
  }
}
