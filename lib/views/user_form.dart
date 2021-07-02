import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if(isValid){
                _form.currentState!.save();
                
                Provider.of<Users>(context, listen: false).put(
                 User(
                   id: _formData['id'].toString(),
                   name: _formData['name'].toString(),
                   email: _formData['email'].toString(),
                   avatarUrl: _formData['avatarUrl'].toString(),
                 ), 
                );

                Navigator.of(context).pop();
              }
            },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value){
                  if(value == null || value.trim().isEmpty) {
                    return 'Nome inválido.';
                  }

                  if(value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 letras.';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value.toString(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value){
                  if(value == null || value.trim().isEmpty) {
                    return 'E-mail inválido.';
                  }

                  return null;
                },
                onSaved: (value) => _formData['email'] = value.toString(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                /* validator: (value){
                  if(value == null || value.trim().isEmpty) {
                    return 'URL inválida.';
                  }

                  return null;
                }, */
                onSaved: (value) => _formData['avatarUrl'] = value.toString(),
              ),
            ],
          ),
        ),
        ),
    );
  }
}