import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:firebase_test/pages/wrapper.dart';
import 'package:firebase_test/shared/auth_service.dart';
import 'package:firebase_test/shared/configs.dart';
import 'package:firebase_test/pages/laoding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // it is needed to start firebase core
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fpapp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill App',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Configs.mainColor,
      ),
      home: FutureBuilder(
        future: _fpapp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('error! ${snapshot.error.toString()}');
            return Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Center(
                    child: Column(
                  children: [
                    Image.asset('assets/sth wrong.png'),
                    const Text('Something went wrong!'),
                  ],
                )));
          } else if (snapshot.hasData) {
            // print(snapshot.data);
            return StreamProvider.value(
                value: AuthService().user,
                initialData: null,
                child: const Wrapper());
          } else {
            // print('else');
            return const Scaffold(
              body: Loading(),
            );
          }
        },
      ),
    );
  }
}
