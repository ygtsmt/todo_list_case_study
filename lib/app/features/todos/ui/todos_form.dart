import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteDescriptionController = TextEditingController();
  final TextEditingController _noteAddressController = TextEditingController();
  String userUID = "";
  String imageUrl = "";
  String? todoUuid;
  var uuid = const Uuid();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _photo;
  Image? _todoImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    userUID = auth.currentUser!.uid;
    todoUuid = uuid.v1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Not Ekle"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<TodoBloc, TodoState>(
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
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text("Başlangıç Tarihi"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text("Bitiş Tarihi"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(onPressed: () {}, child: const Text("Konumunu Ekle"))),
                      SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                _showPicker(context);
                              },
                              child: const Text("Görsel Ekle"))),
                      _todoImage != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(height: 200, child: _todoImage),
                            )
                          : Container(),
                      SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                              onPressed: () {
                                final todo = TodoModel(
                                    id: todoUuid,
                                    title: _noteTitleController.text,
                                    description: _noteDescriptionController.text,
                                    address: _noteAddressController.text,
                                    startDate: "_selectedFirstDate.toString()",
                                    finishDate: "_selectedLastDate.toString()",
                                    location: "location",
                                    imageUrl: imageUrl);

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
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galeriden Seç'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Fotoğraf Çek'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _todoImage = Image.file(_photo!);
        uploadFile(todoUuid!, userUID);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _todoImage = Image.file(_photo!);
        uploadFile(todoUuid!, userUID);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future uploadFile(String todoId, String userUid) async {
    if (_photo == null) return;

    final fileName = todoId;
    final destination = 'usersTodoPhotos/$userUid/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      final uploadTask = ref.putFile(_photo!);
      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final url = await taskSnapshot.ref.getDownloadURL();
      imageUrl = url;
    } catch (e) {
      debugPrint('Hata oluştu: $e');
    }
  }
}
