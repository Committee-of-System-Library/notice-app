import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knu_notice/src/components/message_popup.dart';
import 'package:knu_notice/src/pages/like.dart';
import 'package:knu_notice/src/pages/more.dart';
import 'package:knu_notice/src/pages/notice.dart';

enum PageName { LIKE, NOTICE, MORE }

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _pageIndex = 1;

  final List<int> _bottomHistory = [1];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopAction,
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(
            index: _pageIndex,
            children: [
              Like(),
              Notice(),
              More(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.5,
                ),
              ],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black38,
                currentIndex: _pageIndex,
                onTap: (value) => changeBottomNav(value),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.abc),
                    label: '즐겨찾기',
                    activeIcon: Icon(Icons.abc),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.abc),
                    label: '게시물',
                    activeIcon: Icon(Icons.abc),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.abc),
                    label: '더보기',
                    activeIcon: Icon(Icons.abc),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.LIKE:
      case PageName.NOTICE:
      case PageName.MORE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    setState(() {
      _pageIndex = value;
    });
    if (!hasGesture) return;
    if (!_bottomHistory.contains(value)) {
      _bottomHistory.add(value);
      print(_bottomHistory);
    }
  }

  Future<bool> willPopAction() async {
    if(_bottomHistory.length==1) {
      showDialog(
        context: context,
        builder: (context) => MessagePopup(
          message: '종료하시겠습니까?',
          okCallback: (){
            exit(0);
          },
          cancelCallback: Navigator.of(context).pop,
          title: '시스템',
        ),
      );
      print('exit!');
      return true;
    }

    _bottomHistory.removeLast();
    var index = _bottomHistory.last;
    changeBottomNav(index,hasGesture: false);
    print(_bottomHistory);
    return false;
  }
}
