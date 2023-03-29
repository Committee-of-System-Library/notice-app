

import 'package:flutter/material.dart';
import 'package:knu_notice/src/pages/like.dart';
import 'package:knu_notice/src/pages/more.dart';
import 'package:knu_notice/src/pages/notice.dart';

enum PageName{LIKE,NOTICE,MORE}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  int _pageIndex=1;
  final List<int> _bottomHistory=[2];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopAction,
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
              onTap: (value)=>changeBottomNav(value),
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
    );
  }





  void changeBottomNav(int value, {bool hasGesture =true}) {
    var page = PageName.values[value];
    switch(page){
      case PageName.LIKE:
      case PageName.NOTICE:
      case PageName.MORE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture =true}){
    _pageIndex= value;
    if(!hasGesture) return;
    if(!_bottomHistory.contains(value)){
      _bottomHistory.add(value);
      print(_bottomHistory);
    }


  }

  Future<bool> willPopAction() async {
    if (_bottomHistory.length>1){
      _bottomHistory.removeLast();
      var index = _bottomHistory.last;
      changeBottomNav(index,hasGesture: false);
      print(_bottomHistory);
      return false;
    }

    return true;
  }
}
