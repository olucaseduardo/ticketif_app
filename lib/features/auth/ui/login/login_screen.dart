import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset('assets/ifma_logo.png'),
                ),
                SizedBox(height: 30,),
                Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration:InputDecoration(
                        labelText: "Matrícula",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.teal,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          gapPadding: 6,
                          borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: !passwordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.teal,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: (){}, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("LOGIN",
                                style: TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        ],
                      ),
                        style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
