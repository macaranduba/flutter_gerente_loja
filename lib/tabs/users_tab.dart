import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/user_title.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: ListView.separated(
            itemBuilder: (context, index) {
              return UserTile();
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 50
          ),
        )
      ],
    );
  }
}
