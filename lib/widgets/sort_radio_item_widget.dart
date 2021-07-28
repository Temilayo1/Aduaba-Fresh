import 'package:aduaba_app/model/sort_model.dart';
import 'package:flutter/material.dart';

class SortRadioItem extends StatelessWidget {
  final SortOptionsModel _item;
  SortRadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  _item.text,
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF10151A),
                      fontWeight:
                          _item.isSelected ? FontWeight.w700 : FontWeight.w400),
                ),
              ),
              _item.isSelected
                  ? Container(
                      height: 30.0,
                      width: 30.0,
                      child: Center(
                        child: Checkbox(
                          activeColor: Colors.transparent,
                          checkColor: Color(0xFF3C673D),
                          // value: _item.isSelected ? true : false,
                          value: true,
                          tristate: false,
                          onChanged: (value) {},
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Divider(
          color: Color(0xFFF5F5F5),
          // color: Colors.grey,
          thickness: 1,
          height: 0,
        )
      ],
    );
  }
}
