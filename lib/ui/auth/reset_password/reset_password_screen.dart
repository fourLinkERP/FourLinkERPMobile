import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/general/reset_password/reset_password_service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with SingleTickerProviderStateMixin{

  final _formKey = GlobalKey<FormState>();
  final ResetPasswordApiService _resetPasswordApiService = ResetPasswordApiService();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isOldPassword = true;
  bool _isPassword = true;
  bool _isPasswordConfirm = true;
  bool isChanged = false;
  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _onSendPressed(String oldPass, String newPass, String confirmPass) async {
    if (_formKey.currentState!.validate()) {
      _buttonController.forward().then((value) {
        _buttonController.reverse();
      });
      isChanged = await _resetPasswordApiService.changePassword(oldPass, newPass, confirmPass);
      if(isChanged == true){

        FN_showToast(context, "change_success".tr(), Colors.black87);
        Navigator.pop(context);
      }
      else{
        FN_showToast(context, "change_failed".tr(), Colors.black87);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        title: Center(
          child: Text(
            'change_pass'.tr(),
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Cairo',
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'enter_new_pass'.tr(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Cairo'
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _oldPasswordController,
                obscureText: _isOldPassword,
                decoration: InputDecoration(
                  labelText: 'old_password'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.amberAccent,),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isOldPassword = !_isOldPassword;
                      });
                    },
                    icon : Icon(_isOldPassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter_password'.tr();
                  } else if (value.length < 6) {
                    return 'password_strength'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: _isPassword,
                decoration: InputDecoration(
                  labelText: 'password'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.amberAccent,),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isPassword = !_isPassword;
                      });
                    },
                    icon : Icon(_isPassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter_password'.tr();
                  } else if (value.length < 6) {
                    return 'password_strength'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isPasswordConfirm,
                decoration: InputDecoration(
                  labelText: 'confirm_password'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.amberAccent,),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isPasswordConfirm = !_isPasswordConfirm;
                      });
                    },
                    icon : Icon(_isPasswordConfirm ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter_confirmation_password'.tr();
                  }
                  else if (value != _passwordController.text) {
                    return 'Confirm_password_does_not_match'.tr();
                  }
                  else if (value.length < 6) {
                    return 'password_strength'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              Container(
                margin: const EdgeInsets.only(left: 100, right: 100),
                child: GestureDetector(
                  onTap: (){
                    _onSendPressed(_oldPasswordController.text, _passwordController.text, _confirmPasswordController.text);
                  },
                  child: AnimatedBuilder(
                    animation: _buttonController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _buttonAnimation.value,
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(144, 16, 46, 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'verify'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
