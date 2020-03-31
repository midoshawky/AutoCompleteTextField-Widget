import 'package:flutter/material.dart';
import 'package:testapp/AutoCompeleteTxtField/nonGlow.dart';

class AutoCompeleteTextField extends StatefulWidget {
  final List<String> suggestions;
  final decoration;
  final listElevation;
  final width;
  final onTextSubmited;
  final collapsed;
  AutoCompeleteTextField(
      {Key key,
      @required this.suggestions,
      this.decoration,
      this.listElevation,
      this.width,
      this.onTextSubmited(String value),
      this.collapsed
      });

  @override
  _MACTextFieldState createState() => _MACTextFieldState();
}

class _MACTextFieldState extends State<AutoCompeleteTextField> {
  List<String> _List = [];
  List<String> tempList;
  var _Size;
  var view;
  double _ListHight;

  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _Size = 0;
    _ListHight = 0.0;
    print(_List);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: widget.decoration,
            onChanged: (val) => _SuggestionsFilter(val),
            onSubmitted: (val) => widget.onTextSubmited(val),
          ),
          (widget.collapsed == null|| widget.collapsed == false) ? Card(
            elevation: widget.listElevation,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                transform: Matrix4.translationValues(0, _ListHight * _Size, 0),
                height: _Size * 55.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: _SuggestionList(_List)),
          ) : Container(child: _SuggestionList(_List),height: 40.0,)
        ],
      ),
      width: 250.0,
    );
  }

  Widget _SuggestionList(List SList) {
    return ScrollConfiguration(
      child: ListView.builder(
          scrollDirection: (widget.collapsed == null|| widget.collapsed == false) ? Axis.vertical:Axis.horizontal,
          itemCount: SList.length,
          padding: EdgeInsets.only(top: 0),
          primary: true,
          itemBuilder: (context, indx) =>(widget.collapsed == null|| widget.collapsed == false) ? _NonCollapsed(SList, indx):_Collapsed(SList, indx)),
      behavior: nonGlow(),
    );
  }

  Widget _NonCollapsed(List SList,indx){
    return ListTile(
      title: Text(SList[indx].toString()),
      onTap: () {
        _controller.text = SList[indx].toString();
        setState(() {
          _List.clear();
          _Size = 0.0;
        });
      },
      onLongPress: () {
        _controller.text = SList[indx].toString();
        setState(() {
          _List.clear();
          _Size = 0.0;
        });
      },
    );
  }
  Widget _Collapsed(List SList,indx){
    return GridTile(
      child: GestureDetector(
        child: Padding(
          child: Container(
            child: Center(child: Text(SList[indx].toString()),),
          ),
          padding: EdgeInsets.only(right: 8,left: 8),
        ),
        onTap: () {
          _controller.text = SList[indx].toString();
          setState(() {
            _List.clear();
            _Size = 0.0;
          });
        },
        onLongPress: () {
          _controller.text = SList[indx].toString();
          setState(() {
            _List.clear();
            _Size = 0.0;
          });
        },
      )

    );
  }
  void _SuggestionsFilter(txtValue) {
    _List.clear();
    for (var value in widget.suggestions) {
      if (txtValue != '' && _igonreCaseSenstivity(value,txtValue)) {
        _List.add(value);
        view = _SuggestionList(_List);
      }
    }
    setState(() {
      _Size = _List.length;
      print("$_Size , $_ListHight, $_List");
    });
  }
  bool _igonreCaseSenstivity(String value,String txtValue){
    var exprsion = (value.toLowerCase().startsWith(txtValue.toString().toLowerCase()) ||
        value.toLowerCase().startsWith(txtValue.toString().toLowerCase()));
    return exprsion;
  }

}
