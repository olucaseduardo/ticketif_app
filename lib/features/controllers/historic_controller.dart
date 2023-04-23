import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoricController extends ChangeNotifier{
     int countOne = 5;
     int countTwo = 5;
     int countTree = 5;

     RefreshController refreshController =
     RefreshController(initialRefresh: false);

     void onRefresh() async{
          // monitor network fetch
          await Future.delayed(const Duration(milliseconds: 1000));
          countOne+=1;
          // if failed,use loadFailed(),if no data return,use LoadNodata()
          // items.add((items.length+1).toString());
          // if(mounted)
          //      setState(() {
          //
          //      });
          notifyListeners();
          // if failed,use refreshFailed()
          refreshController.refreshCompleted();
     }

     void onLoading() async{
          // monitor network fetch
          await Future.delayed(const Duration(milliseconds: 1000));
          countOne+=1;
          // if failed,use loadFailed(),if no data return,use LoadNodata()
          // items.add((items.length+1).toString());
          // if(mounted)
          //      setState(() {
          //
          //      });
          notifyListeners();
          refreshController.loadComplete();
     }

}