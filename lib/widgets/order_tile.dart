import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  //const OrderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#1235 - Entregue",
            style: TextStyle(color: Colors.green),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // client's name and order's money value
                  Column( // products column
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('Camiseta Preta P'),
                        subtitle: Text('Camisetas - blabla'),
                        trailing: Text(
                          '2',
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      )
                    ],
                  ),
                  Row( // actions
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text('Excluir'),
                        onPressed: () {  },
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                      TextButton(
                        child: Text('Regredir'),
                        onPressed: () {  },
                        style: TextButton.styleFrom(
                          primary: Colors.grey[850],
                        ),
                      ),
                      TextButton(
                        child: Text('Avançar'),
                        onPressed: () {  },
                        style: TextButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
