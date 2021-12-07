import 'package:bruhh/config/palette.dart';
import 'package:bruhh/cubit/search_cache/searchcache_cubit.dart';
import 'package:bruhh/screen/navscreen/search/search_history_list.dart';
import 'package:bruhh/utils/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  final String? searchKeyWord;
  const SearchScreen({
    Key? key,
    this.searchKeyWord,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.text =
        widget.searchKeyWord == null ? "" : widget.searchKeyWord!;
    BlocProvider.of<SearchcacheCubit>(context).populateSearchHistory();
  }

  Future<void> _updateSearchCache(
      String searchKeyword, SearchcacheCubit cubit) async {
    await cubit.updateSearchHistory(searchKeyword);
    Navigator.pushReplacementNamed(
      context,
      "/wikiResults",
      arguments: DrSearchArgs(
        searchKeyword: searchKeyword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchcacheCubit>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        if (widget.searchKeyWord == null)
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Palette.online,
            systemNavigationBarColor: Palette.mainColor,
          ));
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Palette.p1,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: size.height,
            width: size.width,
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(20),
                      //   color: Palette.online,
                      // ),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        autofocus: true,
                        controller: _textEditingController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm",
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                        onSubmitted: (searchKeyWordd) {
                          if (searchKeyWordd.length > 0) {
                            _updateSearchCache(searchKeyWordd, cubit);
                          }
                        },
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        _textEditingController.clear();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Divider(),
              BlocBuilder<SearchcacheCubit, SearchcacheState>(
                builder: (context, state) {
                  if (state is SearchcacheLoaded)
                    return Expanded(
                      child: SearchHistory(
                        searchHistory: cubit.searchHistory!,
                        size: size,
                        callback: (String searchText) {
                          setState(() {
                            _textEditingController.text = searchText;
                          });
                          _updateSearchCache(searchText, cubit);
                        },
                      ),
                    );
                  else
                    return SizedBox();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
