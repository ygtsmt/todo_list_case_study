import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscureText = true;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNickName = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userSurnameController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  Widget build(final BuildContext context) {
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
                      textInputAction: TextInputAction.done,
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'error'),
                        ],
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
                      textInputAction: TextInputAction.done,
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'error'),
                        ],
                      ),
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
                textInputAction: TextInputAction.done,
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: 'error'),
                  ],
                ),
              ),
              TextFormField(
                controller: _userNickName,
                decoration: const InputDecoration(
                  labelText: 'E-posta Adresi',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: 'error'),
                  ],
                ),
              ),
              TextFormField(
                controller: _phoneNumberController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Telefon Numarası',
                  prefixIcon: const Icon(
                    Icons.phone_android_outlined,
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: const Text("Kod Gonder"),
                  ),
                ),
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: 'error'),
                  ],
                ),
              ),
              TextFormField(
                controller: _smsCodeController,
                decoration: const InputDecoration(
                  labelText: 'Doğrulama Kodu',
                  prefixIcon: Icon(Icons.onetwothree_outlined),
                ),
                keyboardType: TextInputType.number,
                obscureText: _obscureText,
                textInputAction: TextInputAction.done,
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: 'error'),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {},
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
  }
}
