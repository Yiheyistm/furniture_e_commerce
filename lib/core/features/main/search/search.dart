import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_e_commerce/core/features/main/productDetail/product_details.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/features/main/services/storage_service.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storage = locator<StorageService>();
  List<Map<String, dynamic>> _searchResults = [];
  List<Items> recentSearches = [];
  int _resultsCount = 0;

  @override
  void initState() {
    super.initState();
    _storage.writeIfNull('recentSearches', []);
    _loadRecentSearches();
    _searchController.addListener(() {
      _search(_searchController.text);
    });
  }

  void _loadRecentSearches() {
    final listrecentSearches =
        (_storage.getListData('recentSearches') as List<dynamic>);
    if (listrecentSearches.isNotEmpty) {
      recentSearches = listrecentSearches as List<Items>;
    }
  }

  void _search(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = recentSearches.map((item) => item.toMap()).toList();
        _resultsCount = recentSearches.length;
      });
      return;
    }

    // Fetch data from Firebase
    final QuerySnapshot snapshot = await _firestore
        .collection('items')
        .where('itemName', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('itemName', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
        .get();

    final QuerySnapshot categorySnapshot = await _firestore
        .collection('items')
        .where('category', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('category', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
        .get();

    final QuerySnapshot descriptionSnapshot = await _firestore
        .collection('items')
        .where('itemDescription', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('itemDescription',
            isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
        .get();

    final List<Map<String, dynamic>> results = <Map<String, dynamic>>{
      ...snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>),
      ...categorySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>),
      ...descriptionSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>),
    }.toList(); // Remove duplicates

    setState(() {
      _searchResults = results;
      _resultsCount = results.length;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _search(_searchController.text),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _searchController.text.isEmpty
                  ?
                  // show recent searches with a clear button
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Recent Searches'),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              recentSearches.clear();
                              _storage.setData('recentSearches', []);
                            });
                          },
                          child: const Text('Clear',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    )
                  : Text('Found $_resultsCount results'),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final items = _searchResults[index];
                    if (items['publishedDate'] is Timestamp) {
                      items['publishedDate'] =
                          (items['publishedDate'] as Timestamp)
                              .toDate()
                              .toString();
                    }
                    Items item = Items.fromJson(items);

                    return Card(
                      color: Theme.of(context).canvasColor,
                      child: ListTile(
                        onTap: () {
                          // Update recent searches
                          if (!recentSearches.contains(item)) {
                            recentSearches.add(item);
                            _storage.setData('recentSearches', recentSearches);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                item: item,
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.itemImage!),
                        ),
                        title: Text(item.itemName!),
                        subtitle: Text(item.itemDescription!),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
