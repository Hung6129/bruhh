import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String? searchKeyWord;
  const SearchScreen({
    Key? key,
    this.searchKeyWord,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final TextEditingController _textEditingController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: TextField(
          autocorrect: true,
        ),
      ),
    );
  }
}
