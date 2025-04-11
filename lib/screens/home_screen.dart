import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _dummyCards = List.generate(10, (i) => '카드 뉴스 #${i + 1}');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_isLoading && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _loadMoreCards();
      }
    });
  }

  Future<void> _loadMoreCards() async {
    setState(() => _isLoading = true);

    // 여기서 실제 API 호출 예정
    await Future.delayed(const Duration(seconds: 1));

    final newCards = List.generate(10, (i) => '추가된 카드 뉴스 #${_dummyCards.length + i + 1}');
    setState(() {
      _dummyCards.addAll(newCards);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _dummyCards.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _dummyCards.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_dummyCards[index], style: const TextStyle(fontSize: 18)),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
