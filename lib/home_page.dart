import 'package:balmond_chat/chat_page.dart';
import 'package:balmond_chat/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final PageController _pageController  = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: PageView(
            controller: _pageController,
            children: const [
              ChatPage(),
              ContactPage()
            ],
          ),
          bottomNavigationBar: NavigationBar(
             onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          indicatorColor: Colors.black,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.chat_bubble,color: Colors.white,),
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.perm_contact_calendar_rounded,color: Colors.white,),
              icon: Badge(child: Icon(Icons.perm_contact_calendar_rounded)),
              label: 'Contact',
            ),
            
          ],
      
          )
        );
  }
}