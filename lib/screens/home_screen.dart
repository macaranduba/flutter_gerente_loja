import 'package:flutter/material.dart';
import 'package:gerente_loja/tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
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
