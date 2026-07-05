import 'package:flutter/material.dart';
import 'package:tally_screen/bloc/user_bloc.dart';
import 'package:tally_screen/repository/guide_repo.dart';
import 'package:tally_screen/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tally_screen/repository/quote_repo.dart';
import 'package:tally_screen/screens/login_screen.dart';
import 'firebase_options.dart';


//home_screen
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (context) => UserBloc(
        userRepo: UserRepository(),
        guideRepo: GuideRepository(),
        quoteRepo: QuoteRepository(),
      ),
      child: MaterialApp(debugShowCheckedModeBanner: false,home: const LoginScreen()),
    ),
  );
}
