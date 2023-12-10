import 'package:flutter/material.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier{
N? navigator=null;
}
abstract class BaseNavigator{
void showMessage(String? message);
void showLoading();
void hideDialog();
}
abstract class BaseState<T extends StatefulWidget,VM extends BaseViewModel> extends State<T> implements BaseNavigator{
    late VM viewModel;
    VM initViewModel();
    @override
  void initState() {
    super.initState();
    viewModel =initViewModel();
  }
    @override
    void hideDialog() {
      Navigator.popUntil(context, (route) {
        bool isVisible = route is PopupRoute;
        return !isVisible;
      });  }

    @override
    void showLoading() {
      showDialog(context: context, builder:(_)=> AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 8,),
            Text('Loading')
          ],
        ),
      ));
    }

    @override
    void showMessage(String? message) {
      showDialog(context: context, builder:(_)=> AlertDialog(
        content: Row(
          children: [

            Expanded(child: Text(message?? ''))
          ],
        ),
      ));
    }

}