import 'package:login_app/main.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();

  final _userController = TextEditingController();

  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("CHECKING"),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 35,
        shadowColor: Color.fromARGB(255, 214, 76, 239),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Sign In',
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 3,
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _userController,
                        maxLength: 6,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter the Username',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        // onChanged: (String value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username cannot be empty';
                          } else if (value.length < 5) {
                            return 'Must contain 5 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _passController,
                        maxLength: 5,
                        // keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(
                            Icons.vpn_key,
                            // color: Colors.purple,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Passwords cannot be empty';
                          } else if (value.length < 5) {
                            return 'Must contain  5 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minWidth: double.infinity,
                        onPressed: () {
                          checkLogin(context);
                          if (_formkey.currentState!.validate()) {
                          } else {
                            print('data empty');
                          }
                        },

                        color: Colors.purple,
                        height: 50,
                        textColor: Colors.white,
                        // onPressed: validate,
                        child: const Text('Login'),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  Future<void> checkLogin(BuildContext context) async {
    final _username = _userController.text;
    final _password = _passController.text;
    if (_username == 'Adnan' && _password == '12345') {
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(SAVE_KEY_NAME, true);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => HomeScreen()));

      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
                content: Text('You have successfully logged in'), actions: []);
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username Password dosenot Match'),
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
                content: Text('Sorry,Failed to Log In'), actions: []);
          });
      // print('Username Password dosenot Match');
    }
  }
}
