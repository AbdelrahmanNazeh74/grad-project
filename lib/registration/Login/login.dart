import 'package:flutter/material.dart';
import 'package:graduation_project/my_theme.dart';
import 'package:graduation_project/registration/Login/login_connector.dart';
import 'package:graduation_project/registration/Login/login_viewnodel.dart';
import 'package:graduation_project/student/student.dart';
import 'package:provider/provider.dart';
import '../../base.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login-screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseState<Login, LoginViewModel>
    implements LoginConnector {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Sign In',
              ),
            ),
            body: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextFormField(
                          onChanged: (text) {
                            email = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter your ID';
                            }
                            // bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
                            // if(!emailValid){
                            //   return "Email format not valid";
                            // }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: 'ID',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              icon: Icon(
                                Icons.email,
                                color: MyTheme.secondColor,
                              ),
                              border: InputBorder.none),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: MyTheme.mainColor),
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      Container(
                        child: TextFormField(
                          onChanged: (text) {
                            password = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter your password';
                            }
                            // if(text.trim().length < 6){
                            //   return "Password should be at least 6 characters";
                            // }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              icon: Icon(
                                Icons.lock,
                                color: MyTheme.secondColor,
                              ),
                              border: InputBorder.none),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: MyTheme.mainColor),
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState?.validate() == true) {
                            validateForm();
                          }
                        },
                        child: Container(
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: MyTheme.secondColor,
                          ),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      LoginViewModelDjango().login(email, password, context);
    }
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void gotoStudent() {
    Navigator.pushReplacementNamed(context, Student.routeName);
  }
}
