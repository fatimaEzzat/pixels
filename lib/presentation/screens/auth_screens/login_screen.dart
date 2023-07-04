import 'package:flutter/material.dart';
import 'package:pixels/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/apis/gallery_api.dart';
import '../../../shared/constants.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/validators.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/default_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print('rebuild******');
    return Scaffold(
      backgroundColor: MyColors.splashBG,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo-transparent-png.png',
                        fit: BoxFit.cover,
                        height: 200.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Let art captivate and inspire you',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'PoppinsMedium',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: defaultColor,
                          fontFamily: 'PoppinsMedium'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            validator: Validator.validateEmail,
                            label: 'email',
                            prefixIcon: const IconData(0xe93e,
                                fontFamily: 'IconBroken'),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Consumer(builder: (context, _, __) {
                            return DefaultTextFormField(
                                controller: passController,
                                textInputType: TextInputType.visiblePassword,
                                isPassword:
                                context
                                    .watch<AuthProvider>()
                                    .isPass,
                                validator: Validator.validatePassword,
                                label: 'password',
                                prefixIcon: const IconData(0xe948,
                                    fontFamily: 'IconBroken'),
                                suffixIcon:
                                context
                                    .watch<AuthProvider>()
                                    .suffix,
                                suffixIconPressed: () {
                                  context
                                      .read<AuthProvider>()
                                      .changePassVisibility();
                                });
                          }),
                          const SizedBox(
                            height: 7.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Consumer<AuthProvider>(
                      builder: (context, provider, child) {
                        if (provider.dataState == DataStates.success) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushNamedAndRemoveUntil(context, homeScreen, (route) => false);
                          });
                        }
                        return provider.dataState != DataStates.loading
                            ? DefaultButtonWidget(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              provider.loginByEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text);
                            }
                          },
                          text: 'login',
                          background: defaultColor,
                          radius: 20.0,
                        ): Center(child: CircularProgressIndicator(),);
                      },
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                            child: Text(
                              'Don’t have an account?',
                              style: TextStyle(color: defaultColor,
                                  fontSize: 13.0),
                            )),
                        InkWell(
                          child: const Text(
                            'Create an account',
                            style:
                            TextStyle(color: defaultColor, fontSize: 13.0),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, registerScreen);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Visibility(
                      visible: true,
                      child: GestureDetector(
                        onTap: () {
                           Navigator.pushNamed(context, homeScreen);
                        },
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Go as visitor',
                            style: TextStyle(
                                color: defaultColor,
                                fontSize: 15.0,
                                fontFamily: 'PoppinsMedium'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
