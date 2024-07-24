
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:chat_app/signInScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyCPxlM95dwAzNtnr7B3bJ38vh9mYmgDu5U',
    appId: '1:916652107353:android:25cdd400d9d105c2aa7348',
    messagingSenderId: '916652107353',
    projectId: 'chatapp-d8b39',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      themeMode: ThemeMode.light,
      home: AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  AuthGate({Key? key}) : super(key: key);
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
         stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("something went wrong with firebase");
          } else if (snapshot.hasData) {
            print("firebase connected");
            return const MyHomePage();
          } else {
            return const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration()
              ],
            );
          }
        });
    // FutureBuilder(future: _firebaseApp,
    //   builder: (context, snapshot){
    //     if(snapshot.hasError){
    //       return  Text("something went wrong with firebase");
    //     }else if(snapshot.hasData){
    //       print("firebase connected");
    //       return  MyHomePage();
    //     }else{
    //       return CircularProgressIndicator();
    //     }
    //   },);
  }
}
