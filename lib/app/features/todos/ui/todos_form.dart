import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_bloc.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_event.dart';
import 'package:todo_list_case_study/app/features/todos/bloc/todos_state.dart';
import 'package:todo_list_case_study/app/features/todos/data/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodosFormScreen extends StatefulWidget {
  const TodosFormScreen({super.key});

  @override
  State<TodosFormScreen> createState() => _TodosFormScreenState();
}

class _TodosFormScreenState extends State<TodosFormScreen> {
  DateTime _selectedFirstDate = DateTime.now();
  DateTime _selectedLastDate = DateTime.now();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteDescriptionController = TextEditingController();
  final TextEditingController _noteAddressController = TextEditingController();
  String userUID = "";
  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    userUID = auth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Not Ekle"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return SafeArea(
            minimum: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _noteTitleController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Not Başlığı',
                        prefixIcon: Icon(
                          Icons.title_outlined,
                        ),
                      ),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'Boş bırakılamaz.'),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _noteDescriptionController,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Not İçeriği',
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                        ),
                      ),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'Boş bırakılamaz.'),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _noteAddressController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Yer Bilgisi',
                        prefixIcon: Icon(
                          Icons.location_city_outlined,
                        ),
                      ),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'Boş bırakılamaz.'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () {
                                      _selectFirstDate(context);
                                    },
                                    child: const Text("Başlangıç Tarihi")))),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () {
                                      _selectLastDate(context);
                                    },
                                    child: const Text("Bitiş Tarihi")))),
                      ],
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () {
                              _selectFirstDate(context);
                            },
                            child: const Text("Konumunu Ekle"))),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () {
                              _selectFirstDate(context);
                            },
                            child: const Text("Görsel Ekle"))),
                    SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                            onPressed: () {
                              final todo = TodoModel(
                                id: uuid.v1(),
                                title: _noteTitleController.text,
                                description: _noteDescriptionController.text,
                                address: _noteAddressController.text,
                                startDate: _selectedFirstDate.toString(),
                                finishDate: _selectedLastDate.toString(),
                                location: "location",
                              );
                              BlocProvider.of<TodoBloc>(context).add(AddTodo(todo, userUID));
                              Navigator.pop(context);
                            },
                            child: const Text("OLUŞTUR"))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectFirstDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedFirstDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedFirstDate) {
      setState(() {
        _selectedFirstDate = picked;
      });
    }
  }

  Future<void> _selectLastDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedLastDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedLastDate) {
      setState(() {
        _selectedLastDate = picked;
      });
    }
  }
}
