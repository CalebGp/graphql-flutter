import 'package:client_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _hobbyformKey = GlobalKey<FormState>();
  final _postformKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController hobbyTitle = TextEditingController();
  TextEditingController hobbyDescription = TextEditingController();
  TextEditingController postComment = TextEditingController();
  bool _isSaving = false;
  bool _isSavingHobby = false;
  bool _isSavingPost = false;
  bool _visibleHobby = false;
  bool _visiblePost = false;
  void _toggleHobby() {
    _visibleHobby = !_visibleHobby;
  }

  void _togglePost() {
    _visiblePost = !_visiblePost;
  }

  var currentUserId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add a User",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                color: Colors.grey.shade300,
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            children: [
              Mutation(
                options: MutationOptions(
                  document: gql(_insertUser()),
                  fetchPolicy: FetchPolicy.noCache,
                  onCompleted: (data) {
                    print(data);
                    setState(() {
                      _isSaving = false;
                      _toggleHobby();
                      currentUserId = data!["CreateUser"]["id"];
                    });
                  },
                  onError: (error) => print(error),
                ),
                builder: (runMutation, result) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: name,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: profession,
                          decoration: const InputDecoration(
                            labelText: "Profession",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Profession cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: age,
                          decoration: const InputDecoration(
                            labelText: "Age",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Age cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Colors.greenAccent,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isSaving = true;
                                    });
                                    runMutation({
                                      "name": name.text.trim(),
                                      "age": int.parse(
                                        age.text.trim(),
                                      ),
                                      "profession": profession.text.trim(),
                                    });
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 36,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "Save",
                                  ),
                                ),
                              )
                      ],
                    ),
                  );
                },
              ),
              Visibility(
                visible: _visibleHobby,
                child: Mutation(
                  options: MutationOptions(
                    document: gql(_insertHobby()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      print(data);

                      setState(() {
                        _visiblePost = true;
                        _isSavingHobby = false;
                      });
                    },
                    onError: (error) => print(error),
                  ),
                  builder: (runMutation, result) {
                    return Form(
                      key: _hobbyformKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: hobbyTitle,
                            decoration: const InputDecoration(
                              labelText: "Hobby",
                              hintText: "title",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Hobby cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: hobbyDescription,
                            decoration: const InputDecoration(
                              labelText: "Description",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Hobby cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          _isSavingHobby
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Colors.greenAccent,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isSavingHobby = true;
                                      });
                                      runMutation({
                                        "title": hobbyTitle.text.trim(),
                                        "description":
                                            hobbyDescription.text.trim(),
                                        "userId": currentUserId,
                                      });
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 36,
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      "Save",
                                    ),
                                  ),
                                )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: _visiblePost,
                child: Mutation(
                  options: MutationOptions(
                    document: gql(_insertPost()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      print(data);

                      setState(() {
                        _isSavingPost = false;
                      });
                    },
                    onError: (error) => print(error),
                  ),
                  builder: (runMutation, result) {
                    return Form(
                      key: _postformKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: postComment,
                            decoration: const InputDecoration(
                              labelText: "Post ",
                              hintText: "Comment",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Hobby cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          _isSavingPost
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Colors.greenAccent,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isSavingPost = true;
                                      });
                                      runMutation({
                                        "comment": postComment.text.trim(),
                                        "userId": currentUserId,
                                      });
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 36,
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      "Save",
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: _visiblePost,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.greenAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: ((context) => HomeScreen())),
                        (route) => false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    child: Text(
                      "Done",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String _insertUser() {
  return """
  mutation CreateUser(\$name: String!, \$age: Int!, \$profession: String!) {
    CreateUser(name: \$name, age: \$age, profession:\$profession) {
      id
      name
    }
  }
  """;
}

String _insertHobby() {
  return """
  mutation CreateHobby(\$title: String!, \$description: String!, \$userId: String!) {
    CreateHobby(title: \$title, description: \$description, userId: \$userId) {
      id
      title
    }
  }
  """;
}

String _insertPost() {
  return """
  mutation CreatePost(\$comment: String!, \$userId: String!) {
    CreatePost(comment: \$comment, userId: \$userId) {
      id
      comment
    }
  }
  """;
}
