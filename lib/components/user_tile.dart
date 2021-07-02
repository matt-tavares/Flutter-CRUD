import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {

  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
      ? CircleAvatar(child: Icon(Icons.person))
      : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
        children: <Widget>[
          IconButton(
            color: Colors.orange,
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: user
              );
            },
            ),
            IconButton(
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Excluir Usuário'),
                  content: Text('Tem certeza?'),
                  actions: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton(
                      child: Text('Não'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      child: Text('Sim'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              ).then((confirmed) => {
                Provider.of<Users>(context, listen: false).remove(user)
              });
            },
            ),
        ],
      ),
      ),
    );
  }
}