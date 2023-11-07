import 'package:flutter/material.dart';
import 'package:recipe/pages/auth.dart';
import 'package:dio/dio.dart';
import 'package:recipe/db/db_manage.dart';

DatabaseHelper helper = DatabaseHelper.instance;

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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  void fetchApiData() async {
    try {
      Dio dio = Dio();
      String apiUrl = 'http://10.0.2.2:8080/api/v1/app/show_recipe';
      Response response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> apiItems = response.data;
        for (var itemData in apiItems) {
          setState(() {
            items.add({
              'id': itemData['id'],
              'name': itemData['name'] ?? 'No Name',
              'description': itemData['description'] ?? 'No Description',
              'imgUrl': itemData['imgUrl'] ??
                  'https://static.tildacdn.com/tild3561-3765-4165-b964-346662316363/noimage_0.png',
            });
          });
        }
      } else {
        print('Ошибка запроса: ${response.statusCode}');
      }
    } catch (error) {
      print('Произошла ошибка: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                        item['name'], item['description'], item['imgUrl'])));
          },
          leading: item['imgUrl'] != null
              ? Image.network(item['imgUrl'])
              : Icon(Icons.image_not_supported),
          title: Text(item['name']),
          subtitle: Text(
            _truncateDescription(item['description']),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }

  String _truncateDescription(String description) {
    if (description.length > 50) {
      return description.substring(0, 50) + '...';
    }
    return description;
  }
}

class DetailScreen extends StatelessWidget {
  final String itemName;
  final String itemDesc;
  final String itemImg;

  DetailScreen(this.itemName, this.itemDesc, this.itemImg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Image.network(
                itemImg,
                width: 500,
                height: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                itemName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(itemDesc),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchData() async {
    try {
      List<Map<String, dynamic>> allRows = await helper.queryAll();
      String token = "";
      for (Map<String, dynamic> row in allRows) {
        token = row['jwt'];
      }
      final dio = Dio();
      // Замените на реальный URL
      final String apiUrl =
          'http://10.0.2.2:8080/api/v1/app/user/profile_data?token=' + token;

      // Установите заголовок с Bearer токеном
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Ошибка при выполнении GET-запроса');
      }
    } catch (e) {
      throw Exception('Произошла ошибка: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        } else {
          final data = snapshot.data as Map<String, dynamic>;
          final username = data['username'];
          final email = data['email'];

          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text("Username: $username"),
                      Text("Email: $email"),
                      ElevatedButton(
                        onPressed: () async {
                          await helper.deleteAll();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthScreen()));
                        },
                        child: Text("Выйти"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
