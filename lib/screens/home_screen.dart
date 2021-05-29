import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/user_bloc.dart';
import 'package:gerente_loja/tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _pageNumber = 0;

  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
  }

  @override
  void dispose() {
    // no need to dispose _userBloc because BlocProvider takes care of that for us
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: BlocProvider(
          blocs: [
            Bloc((i) => _userBloc),
          ],
          dependencies: [],
          child: PageView(
            children: [
              UsersTab(),
              Container(color: Colors.green),
              Container(color: Colors.red),
            ],
            controller: _pageController,
            /*onPageChanged: (selectedPageNumber) {
              setState(() {
                _pageNumber = selectedPageNumber;
              });
            },*/
            onPageChanged: (selectedPageNumber) =>
              setState( () => _pageNumber = selectedPageNumber ),
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.pinkAccent, // background color
          primaryColor: Colors.white,     // icons color
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white)
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _pageNumber,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Produtos',
            ),
          ],
          onTap: (pageNumber) {
            _pageController.animateToPage(pageNumber,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease
            );
          },
        ),
      ),
    );
  }
}
