import 'package:flutter/material.dart';
import 'package:tally_screen/bloc/user_bloc.dart';
import 'package:tally_screen/bloc/user_event.dart';
import 'package:tally_screen/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_screen/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xF5F5F5F5),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Try Out: test_user"),
              resuableTextField(hintText: "Enter user id", controller: userid),
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  //calling test id to reload and navigate
                  if (state.user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyApp(),
                      ),
                    );
                  }
                  if (state.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error!),
                      ),
                    );
                  }
                },
                child: TextButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LoadHome(userid.text));
                  },
                child: Text("GO TRIAL")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextField resuableTextField({
  required String hintText,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      border: OutlineInputBorder(borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}
