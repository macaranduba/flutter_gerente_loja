import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/user_bloc.dart';
import 'package:gerente_loja/widgets/user_title.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userBloc = UserBloc();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Pesquisar',
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search, color: Colors.white,),
            )
          ),
        ),
        Expanded( // just to avoid runtime error due to Column -> ListView.separated hierarchy
          // where those 2 widgets try to reach the height limite when there is not one
          child: StreamBuilder<List>(
            stream: _userBloc.outUsers,
            builder: (context, snapshot) {
              if( ! snapshot.hasData ) {
                return Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent)
                  )
                );
              } else if (snapshot.data.length == 0) {
                return Center(child: Text('Nenhum usuário encontrado!',
                  style: TextStyle(color: Colors.pinkAccent))
                );
              } else
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return UserTile(snapshot.data[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: snapshot.data.length
                );
            }
          ),
        )
      ],
    );
  }
}
