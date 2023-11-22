import 'package:flutter/material.dart';
import 'package:login_app/screens/chat.dart';
import 'package:login_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> image = [
    'https://i.pinimg.com/550x/e4/4c/fa/e44cfad6597bd305a41508e1d6a56c3c.jpg',
    'https://i.pinimg.com/originals/62/5b/1e/625b1ea476ec2d84af0aebcb135d90a5.jpg',
    'https://static.toiimg.com/photo/msid-96397282/96397282.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGnFdKSPElQA0KUbaS_ha0W3MlNP9GgmgtJAuQ6lU&s',
    'https://static.toiimg.com/photo/msid-96397282/96397282.jpg',
    'https://i.pinimg.com/originals/62/5b/1e/625b1ea476ec2d84af0aebcb135d90a5.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSbzeinP-tGlX61Ax9B7oSJ1FMou7CsrDu0A&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGnFdKSPElQA0KUbaS_ha0W3MlNP9GgmgtJAuQ6lU&s',
    'https://pbs.twimg.com/media/DomqpbzU8AAbjLX.jpg',
    'https://i.pinimg.com/originals/62/5b/1e/625b1ea476ec2d84af0aebcb135d90a5.jpg',
    'https://static.toiimg.com/photo/msid-96397282/96397282.jpg',
  ];
  List<String> name = [
    'MOM',
    'DAD',
    'MUHAMMED',
    'LUTHAIF',
    'HADHY',
    'FOUZAN',
    'ISMAIL',
    'JASEEM',
    'ADHIL',
    'DANISH',
    // 'POTH',
    // 'USMAN',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 102, 94, 94),
      appBar: AppBar(
        leading: const Icon(Icons.home),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 4), () {
                        Navigator.of(context).pop(true);
                      });
                      return AlertDialog(
                          content: const Text(
                              'Are you sure you want to delete this'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.clear();
                                  SharedPreferences tectcontrol =
                                      await SharedPreferences.getInstance();
                                  await tectcontrol.clear();
                                  await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: const Text(
                                  'delete',
                                )),
                            TextButton(
                                onPressed: () {}, child: const Text('cancel'))
                          ]);
                    });
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                SharedPreferences tectcontrol =
                    await SharedPreferences.getInstance();
                await tectcontrol.clear();
                await Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: const Icon(Icons.logout)),
        ],
        title: const Text("home page"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        elevation: 60.2,
      ),
      body: Container(
        child: SafeArea(
          child: ListView.separated(
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(name: name[index]),
                      ),
                    );
                  },
                  title: Text(name[index]),
                  subtitle: const Text("Hey there! Iam using adnan's app "),
                  leading: // index % 2 == 0
                      CircleAvatar(
                    radius: 34,
                    backgroundImage: NetworkImage(image[index]),
                  ),
                  trailing: Text('$index:00pm'),
                );
              },
              separatorBuilder: ((ctx, index) {
                return const Divider();
              }),
              itemCount: name.length),
        ),
      ),
    );
  }
}
