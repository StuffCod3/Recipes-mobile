import 'package:flutter/material.dart';
import 'package:recipe/pages/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список рецептов"),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen(),
          ProfileScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Элемент 1',
      'image': 'https://img.freepik.com/free-photo/a-cupcake-with-a-strawberry-on-top-and-a-strawberry-on-the-top_1340-35087.jpg?w=740&t=st=1698681530~exp=1698682130~hmac=9edf8ccae05e65b6c7d027bf830c39efb3dbc8eef30996e07f534c1c151f8b3c',
    },
    {
      'name': 'Элемент 2',
      'image': 'https://img.freepik.com/free-photo/a-cupcake-with-a-strawberry-on-top-and-a-strawberry-on-the-top_1340-35087.jpg?w=740&t=st=1698681530~exp=1698682130~hmac=9edf8ccae05e65b6c7d027bf830c39efb3dbc8eef30996e07f534c1c151f8b3c',
    },
    {
      'name': 'Элемент 3',
      'image': 'https://img.freepik.com/free-photo/a-cupcake-with-a-strawberry-on-top-and-a-strawberry-on-the-top_1340-35087.jpg?w=740&t=st=1698681530~exp=1698682130~hmac=9edf8ccae05e65b6c7d027bf830c39efb3dbc8eef30996e07f534c1c151f8b3c',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(item['name'])));},
          leading: Image.network(item['image']),
          title: Text(item['name']),
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String itemText;

  DetailScreen(this.itemText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали'),
      ),
      body: Center(
        child: Text('Вы выбрали: $itemText'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text("Username"),
                Text("Email"),
                ElevatedButton(
                    onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));},
                    child: Text("Выйти"))
              ],
            ),
          )

        ],
      ),
    );
  }
}

