import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../constants/app_constants.dart';
import '../constants/app_regex.dart';
import '../constants/app_routes.dart';
import '../constants/app_strings.dart';
import '../constants/app_theme.dart';
import '../controllers/LoginController.dart';
import '../helpers/navigation_helper.dart';
import '../helpers/snackbar_helper.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/gradient_background.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends StateMVC<RegisterPage> {


  late LoginController _con;

  _RegisterPageState() : super(LoginController()) {
    _con = controller as LoginController;
  }
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController lastNameController;
  late final TextEditingController middleNameController;
  late final TextEditingController addressController;
  late final TextEditingController idController;
  late final TextEditingController dobController;
  late final TextEditingController phoneController;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void initializeControllers() {
    nameController = TextEditingController()..addListener(controllerListener);
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);

    lastNameController = TextEditingController()
      ..addListener(controllerListener);
    middleNameController = TextEditingController()
      ..addListener(controllerListener);
    addressController = TextEditingController()
      ..addListener(controllerListener);
    idController = TextEditingController()
      ..addListener(controllerListener);
    dobController = TextEditingController()
      ..addListener(controllerListener);
    phoneController = TextEditingController()
      ..addListener(controllerListener);
  }
DateTime? selectedDate;
  String? selectedGenderOption='male';
  String? selectedMartitalOption='single';
  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty&& selectedDate==null&&phoneController.text.isEmpty&&addressController.text.isEmpty&& idController.text.isEmpty&& lastNameController.text.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)&& selectedDate!=null&&phoneController.text.isNotEmpty&&addressController.text.isNotEmpty&& idController.text.isNotEmpty&& lastNameController.text.isNotEmpty) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: ListView(
        children: [
          const GradientBackground(
            children: [
              Text(AppStrings.register, style: AppTheme.titleLarge),
              SizedBox(height: 6),
              Text(AppStrings.createYourAccount, style: AppTheme.bodySmall),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings.name,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterName
                          : value.length < 4
                              ? AppStrings.invalidName
                              : null;
                    },
                    controller: nameController,
                  ),
                  AppTextFormField(
                    labelText: AppStrings.lastname,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterLastName
                          : value.length < 4
                          ? AppStrings.invalidLastName
                          : null;
                    },
                    controller: lastNameController,
                  ),
                  AppTextFormField(
                    labelText: AppStrings.middlename,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return null;
                    },
                    controller: middleNameController,
                  ),
                  AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings.idNumber,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterID
                          : value.length < 4
                          ? AppStrings.invalidAIdNumber
                          : null;
                    },
                    controller: idController,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Gender"),
                      SizedBox(height: 10,),
                      RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'male',
                        groupValue: selectedGenderOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGenderOption = value;
                            print("Selected Option: $selectedGenderOption");
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'female',
                        groupValue: selectedGenderOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGenderOption = value;
                            print("Selected Option: $selectedGenderOption");
                          });
                        },
                      ),
                    ],
                  ),
const SizedBox(height: 10,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Marital status"),
                      SizedBox(height: 10,),
                      RadioListTile<String>(
                        title: const Text('Single'),
                        value: 'single',
                        groupValue: selectedMartitalOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartitalOption = value;
                            print("Selected Option: $selectedMartitalOption");
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Married'),
                        value: 'married',
                        groupValue: selectedMartitalOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartitalOption = value;
                            print("Selected Option: $selectedMartitalOption");
                          });
                        },
                      ),

                      RadioListTile<String>(
                        title: const Text('Divorced'),
                        value: 'divorced',
                        groupValue: selectedMartitalOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartitalOption = value;
                            print("Selected Option: $selectedMartitalOption");
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter DOB',
                    ),
                    validator: (v){
                      if(selectedDate==null){
                        return 'Please enter date';
                      }
                      else{
                        return null;
                      }
                    },
                    firstDate: DateTime.now().subtract(const Duration(days: (365*100))),
                    lastDate: DateTime.now().subtract(const Duration(days: (365*10))),
                    initialPickerDateTime: DateTime.now().subtract(const Duration(days: (365*11))),
                    onChanged: (DateTime? value) {
                      selectedDate = value;
                    },
                  ),
                  SizedBox(height: 10,),
                  AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings.address,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterAddress
                          : value.length < 4
                          ? AppStrings.invalidAddress
                          : null;
                    },
                    controller: addressController,
                  ),

                  AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings.phone,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterPhone
                          : value.length < 4
                          ? AppStrings.invalidPhone
                          : null;
                    },
                    controller: phoneController,
                  ),
                  AppTextFormField(
                    labelText: AppStrings.email,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterEmailAddress
                          : AppConstants.emailRegex.hasMatch(value)
                              ? null
                              : AppStrings.invalidEmailAddress;
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: passwordNotifier,
                    builder: (_, passwordObscure, __) {
                      return AppTextFormField(
                        obscureText: passwordObscure,
                        controller: passwordController,
                        labelText: AppStrings.password,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterPassword
                              : AppConstants.passwordRegex.hasMatch(value)
                                  ? null
                                  : AppStrings.invalidPassword;
                        },
                        suffixIcon: Focus(
                          /// If false,
                          ///
                          /// disable focus for all of this node's descendants
                          descendantsAreFocusable: false,

                          /// If false,
                          ///
                          /// make this widget's descendants un-traversable.
                          // descendantsAreTraversable: false,
                          child: IconButton(
                            onPressed: () =>
                                passwordNotifier.value = !passwordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              passwordObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: confirmPasswordNotifier,
                    builder: (_, confirmPasswordObscure, __) {
                      return AppTextFormField(
                        labelText: AppStrings.confirmPassword,
                        controller: confirmPasswordController,
                        obscureText: confirmPasswordObscure,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseReEnterPassword
                              : AppConstants.passwordRegex.hasMatch(value)
                                  ? passwordController.text ==
                                          confirmPasswordController.text
                                      ? null
                                      : AppStrings.passwordNotMatched
                                  : AppStrings.invalidPassword;
                        },
                        suffixIcon: Focus(
                          /// If false,
                          ///
                          /// disable focus for all of this node's descendants.
                          descendantsAreFocusable: false,

                          /// If false,
                          ///
                          /// make this widget's descendants un-traversable.
                          // descendantsAreTraversable: false,
                          child: IconButton(
                            onPressed: () => confirmPasswordNotifier.value =
                                !confirmPasswordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              confirmPasswordObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: fieldValidNotifier,
                    builder: (_, isValid, __) {
                      return FilledButton(
                        onPressed: isValid
                            ? () {
                                // SnackbarHelper.showSnackBar(
                                //   AppStrings.registrationComplete,
                                // );
                                // nameController.clear();
                                // emailController.clear();
                                // passwordController.clear();
                                // confirmPasswordController.clear();

                          Map map={
                            "first_name":nameController.text,
                            "middle_name":middleNameController.text,
                            "last_name":lastNameController.text,
                            "id_number":idController.text,
                            "dob":DateFormat('yyyy-MM-dd').format(selectedDate!),
                            "marital_status":selectedMartitalOption,
                            "gender":selectedGenderOption,
                            "phone":phoneController.text,
                            "address":addressController.text,
                            "email":emailController.text,
                            "password":passwordController.text
                          };
_con.registerAppUser(map)

                          ;
                              }
                            : null,
                        child: const Text(AppStrings.register),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.iHaveAnAccount,
                style: AppTheme.bodySmall.copyWith(color: Colors.black),
              ),
              TextButton(
                onPressed: () => NavigationHelper.pushReplacementNamed(
                  AppRoutes.login,
                ),
                child: const Text(AppStrings.login),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
