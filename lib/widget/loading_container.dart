import 'package:flutter/material.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/10 18:53
 * @ 描述         加载进度条组件
 */
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool isCover;

  const LoadingContainer(
      {Key key, @required this.isLoading, this.isCover = false, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCover
        ? Stack(
            children: <Widget>[
              child,
              isLoading ? _loadingView : null,
            ],
          )
        : (isLoading ? _loadingView : child);
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
