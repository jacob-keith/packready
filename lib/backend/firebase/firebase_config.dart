import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCSJpMk71LAUuEGm6y2UDJis2PH73FwYvE",
            authDomain: "packready-df249.firebaseapp.com",
            projectId: "packready-df249",
            storageBucket: "packready-df249.firebasestorage.app",
            messagingSenderId: "917726439700",
            appId: "1:917726439700:web:e16ddfd912c7b45299ba01",
            measurementId: "G-ENE79Z3KR1"));
  } else {
    await Firebase.initializeApp();
  }
}
