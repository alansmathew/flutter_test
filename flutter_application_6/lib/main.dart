import 'package:flutter/material.dart';
import 'package:flutter_application_6/ViewModel/viewModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String invalid = "";
  changeText(String text) {
    setState(() {
      invalid = text;
    });
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => ViewModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0.0),
                        child: const Text(
                          'Hello There',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        )),
                    const Spacer()
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 252, 180, 3),
                        Color.fromARGB(255, 255, 111, 0)
                      ]),
                  // color: Color.fromARGB(255,252, 140, 3),
                  boxShadow: [
                    BoxShadow(color: Colors.white, spreadRadius: 0),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 55.0),
                child: Center(
                  child: Text(
                    invalid,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 05.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      // onTap: (){
                      //   changeText('');
                      // },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 40.0),
                child: Column(
                  children: [
                    TextField(
                      // onTap: () {
                      //   changeText('');
                      // },
                      controller: passwordController,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          )),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: true,
                    )
                  ],
                ),
              ),
              Container(
                child: Consumer<ViewModel>(
                  //                    <--- Consumer
                  builder: (context, myModel, child) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black87,
                        // minimumSize: Size(88, 36),
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                      onPressed: () {
                        final String email = emailController.text;
                        final String password = passwordController.text;
                        if (email.isNotEmpty && password.isNotEmpty) {
                          print("login button pressed with valid content !");
                          // checkUser(email, password);
                          // myModel.doSomething();
                          myModel.getLoginData();
                        } else {
                          changeText("Fields cannot be empty !");
                          print("login button pressed without valid content");
                          print("Api call dismissed");
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        height: 50.5,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color.fromARGB(255, 252, 180, 3),
                                Color.fromARGB(255, 255, 111, 0)
                              ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text("User Data"),
                    Consumer<ViewModel>(
                      builder: (context, myModel, child) {
                        if (myModel.usersList.isNotEmpty) {
                          return Text(myModel.usersList.first.name.toString());
                        }
                        return const Text("");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Future<MyModel> someAsyncFunctionToGetMyModel() async {
//   await Future.delayed(Duration(seconds: 3));
//   return MyModel(someValue: 'new data');
// }

// class MyModel with ChangeNotifier {
//   String someValue = "";
//   // MyModel({required this.someValue});
//   Future<void> doSomething() async {
//     print("hello world");
//     await Future.delayed(Duration(seconds: 2));
//     someValue = 'Goodbye';
//     print(someValue);
//     notifyListeners();
//   }
// }
