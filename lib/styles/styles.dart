import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class TextFormDecoration {
  static InputDecoration textForm = InputDecoration(
                  hintText: 'Enter title',
                  // errorText: _phoneErrorText,
                  hintStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey.shade500,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                );
}