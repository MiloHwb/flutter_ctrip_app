import 'package:flutter/material.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/12 20:00
 * @ 描述         
 */

enum SearchBarType { home, normal, homeHighLight }

class SearchBar extends StatefulWidget {
  final bool enabled; //是否禁止搜索
  final bool hideLeft; //是否隐藏左边按钮
  final SearchBarType searchBarType; //搜索框央视
  final String hint; //默认提示文案
  final String defaultText; //默认文字
  final VoidCallback leftButtonClick; //左边按钮回调
  final VoidCallback rightButtonClick; //右边按钮回调
  final VoidCallback speakClick; //语音按钮点击回调
  final VoidCallback inputBoxClick; //搜索框点击
  final ValueChanged<String> onChanged;

  const SearchBar(
      {Key key,
      this.enabled = true,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool showClear = false;

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ? _genNormalSearch() : _genHomeSearch();
  }

  Widget _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            callback: widget.leftButtonClick,
            widget: Container(
              padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget.hideLeft
                  ? null
                  : Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                    ),
            ),
          ),
          Expanded(
            child: _inputBox(),
          ),
          _wrapTap(
            callback: widget.rightButtonClick,
            widget: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '搜索',
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            callback: widget.leftButtonClick,
            widget: Container(
              padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: <Widget>[
                  Text(
                    '上海',
                    style: TextStyle(color: _homeFontColor(), fontSize: 14),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: _homeFontColor(),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _inputBox(),
          ),
          _wrapTap(
            callback: widget.rightButtonClick,
            widget: Icon(
              Icons.comment,
              color: _homeFontColor(),
              size: 26,
            ),
          )
        ],
      ),
    );
  }

  Widget _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xfffededed'));
    }
    return Container(
      height: 35,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: widget.searchBarType == SearchBarType.normal ? Color(0xffa9a9a9) : Colors.blue,
          ),
          Expanded(
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
                    controller: _controller,
                    onChanged: onChanged,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      border: InputBorder.none,
                      hintText: widget.hint ?? '',
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  )
                : _wrapTap(
                    callback: widget.inputBoxClick,
                    widget: Container(
                      child: Text(
                        widget.defaultText,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                  ),
          ),
          showClear
              ? _wrapTap(
                  widget: Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ),
                  callback: () {
                    setState(() {
                      _controller.clear();
                    });
                  })
              : _wrapTap(
                  widget: Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal ? Colors.blue : Colors.grey,
                  ),
                  callback: widget.speakClick),
        ],
      ),
    );
  }

  GestureDetector _wrapTap({@required Widget widget, @required VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: widget,
    );
  }

  void onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeHighLight ? Colors.black54 : Colors.white;
  }
}
