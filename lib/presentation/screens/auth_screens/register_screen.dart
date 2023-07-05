import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../shared/constants.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/icon_broken.dart';
import '../../../shared/validators.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/default_text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

  final passController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileFocusNode = FocusNode();

  // late AuthCubit _authCubit;

  @override
  void initState() {
    // _authCubit = AuthCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColors.splashBG,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            child: const Icon(
              Iconly_Broken.Arrow___Left_2,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/register.png',
                    height: 128.0,
                    width: 134.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    'Create a new account',
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontFamily: 'MonstBold',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    'Complete the account creation and fill in the fields',
                    style: TextStyle(
                        fontSize: 11.5, color: MyColors.greyTextColor),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: DefaultTextFormField(
                                controller: firstNameController,
                                textInputType: TextInputType.emailAddress,
                                validator: Validator.validateName,
                                label: 'First Name',
                                prefixIcon: Iconly_Broken.User1,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              flex: 1,
                              child: DefaultTextFormField(
                                controller: lastNameController,
                                textInputType: TextInputType.emailAddress,
                                validator: Validator.validateName,
                                label: 'Last Name',
                                prefixIcon: Iconly_Broken.User1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DefaultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: Validator.validateEmail,
                          label: 'Email Address',
                          prefixIcon: Iconly_Broken.Message,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Consumer(builder: (context, _, __) {
                          return  DefaultTextFormField(
                                  controller: passController,
                                  textInputType: TextInputType.visiblePassword,
                                  isPassword:
                                      context.watch<AuthProvider>().isPass,
                                  validator: Validator.validatePassword,
                                  label: 'password',
                                  prefixIcon: const IconData(0xe948,
                                      fontFamily: 'IconBroken'),
                                  suffixIcon:
                                      context.watch<AuthProvider>().suffix,
                                  suffixIconPressed: () {
                                    context
                                        .read<AuthProvider>()
                                        .changePassVisibility();
                                    // AuthCubit.get(context).changePassVisibility();
                                  })
                             ;
                        }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DefaultTextFormField(
                          controller: phoneController,
                          //  focusNode: mobileFocusNode,
                          textInputType: TextInputType.phone,
                          isClickable: true,
                          //  validator: Validator.validateEmpty,
                          label: 'Mobile Number (Optional)',
                          prefixIcon: Iconly_Broken.Call,
                          suffixIcon: Text(
                            '+1',
                            style: const TextStyle(
                                color: defaultColor,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          validator: (String? value) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Consumer(builder: (context, AuthProvider provider, _) {
                          if (provider.dataState == DataStates.success) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushNamed(context, homeLayout);
                            });
                          }
                          return provider.dataState != DataStates.loading
                              ? DefaultButtonWidget(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<AuthProvider>()
                                          .registerByFirebaseEmailAndPassword(
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              password: passController.text,
                                              phone: phoneController.text);
                                      //AuthCubit.get(context).login(email: emailController.text, password: passController.text);
                                    }
                                  },
                                  text: 'register',
                                  background: defaultColor,
                                  radius: 20.0,
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        }),

                        const SizedBox(
                          height: 15.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
