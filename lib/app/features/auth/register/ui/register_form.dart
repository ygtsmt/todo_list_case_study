import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo_list_case_study/app/features/auth/login/bloc/phone_auth_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/register/bloc/register_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/register/bloc/register_event.dart';
import 'package:todo_list_case_study/app/features/auth/register/bloc/register_state.dart';
import 'package:todo_list_case_study/app/features/auth/register/data/model/user_model.dart';
import 'package:todo_list_case_study/app/ui/home_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _phoneNumberController = TextEditingController(text: "+90");
  final TextEditingController _userNickName = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userSurnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(final BuildContext context) {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Kod Doğrulandı!"),
            ),
          );
        }
        
        if (state is PhoneAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (context, phoneAuthstate) {
          return BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, registerBlocstate) {
              return SafeArea(
                minimum: const EdgeInsets.all(8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hesap Oluştur!',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Gerekli bilgileri doldurduktan sonra telefonuna gelen SMS kodu ile hesap oluştur!',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _userNameController,
                                decoration: const InputDecoration(
                                  labelText: 'İsim',
                                  prefixIcon: Icon(Icons.person_rounded),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: MultiValidator(
                                  [RequiredValidator(errorText: 'Boş bırakılamaz.')],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _userSurnameController,
                                decoration: const InputDecoration(
                                  labelText: 'Soyisim',
                                  prefixIcon: Icon(Icons.person_rounded),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: MultiValidator([RequiredValidator(errorText: 'Boş bırakılamaz.')]),
                              ),
                            )
                          ],
                        ),
                        TextFormField(
                          controller: _userNickName,
                          decoration: const InputDecoration(
                            labelText: 'Kullanıcı Adı',
                            prefixIcon: Icon(Icons.person_outline_outlined),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: MultiValidator([RequiredValidator(errorText: 'Boş bırakılamaz.')]),
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'E-posta Adresi',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: MultiValidator([RequiredValidator(errorText: 'Boş bırakılamaz.')]),
                        ),
                        if (phoneAuthstate is! PhoneAuthCodeSentSuccess)
                          TextFormField(
                            controller: _phoneNumberController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Telefon Numarası',
                              prefixIcon: const Icon(
                                Icons.phone_android_outlined,
                              ),
                              suffixIcon: TextButton(
                                onPressed: () {
                                  context
                                      .read<PhoneAuthBloc>()
                                      .add(SendOtpToPhoneEvent(phoneNumber: _phoneNumberController.text));
                                },
                                child: const Text("Kod Gönder"),
                              ),
                            ),
                            validator: MultiValidator([RequiredValidator(errorText: 'Boş bırakılamaz.')]),
                          )
                        else
                          Column(
                            children: [
                              TextFormField(
                                controller: _smsCodeController,
                                decoration: const InputDecoration(
                                  labelText: 'Doğrulama Kodu',
                                  prefixIcon: Icon(Icons.onetwothree_outlined),
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                validator: MultiValidator(
                                  [RequiredValidator(errorText: 'Boş bırakılamaz.')],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: () {
                                      context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(
                                          otpCode: _smsCodeController.text,
                                          verificationId: phoneAuthstate.verificationId));
                                    },
                                    child: const Text(
                                      'DOĞRULA',
                                    ),
                                  )),
                            ],
                          ),
                        SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (phoneAuthstate is PhoneAuthVerified) {
                                    final auth = FirebaseAuth.instance;
                                    final user = UserModel(
                                        name: _userNameController.text,
                                        surName: _userSurnameController.text,
                                        nickName: _userNickName.text,
                                        eMail: _emailController.text,
                                        phoneNumber: _phoneNumberController.text);
                                    context.read<RegisterBloc>().add(AddUser(user, auth.currentUser!.uid));

                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => const HomeScreen(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Telefon doğrulaması gerekiyor."),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'HESAP OLUŞTUR',
                              ),
                            )),
                        const SizedBox()
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
