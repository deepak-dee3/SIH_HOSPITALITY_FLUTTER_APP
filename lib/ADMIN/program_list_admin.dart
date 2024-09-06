import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sih2024/PUBLIC/new2.dart';
import 'package:sih2024/ADMIN/program_full_details_admin.dart';
class EventsListPagess_admin extends StatefulWidget {
  @override
  _EventsListPagess_adminState createState() => _EventsListPagess_adminState();
}

class _EventsListPagess_adminState extends State<EventsListPagess_admin> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onTapOutside() {
    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus(); // Hide keyboard when tapping outside
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: _onTapOutside, // Hide keyboard when tapping outside the search bar
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase(); // Update search query
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search hospitals or locations...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('BEFORE EVENT')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
                      return Center(child: Text('No events found.'));
                    }

                    final events = snapshot.data!.docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final hospitalName = data['Hospital_name'].toLowerCase();
                      final program = data['Program'].toLowerCase();
                      final date = data['Date Of Event'].toLowerCase();
                      return hospitalName.contains(_searchQuery) ||
                          program.contains(_searchQuery) ||
                          date.contains(_searchQuery);
                    }).toList();

                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            height: 100,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.blueAccent),
                              ),
                              tileColor: Colors.blue,
                              title: Text(
                                event['Program'].toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_pin, color: Colors.green),
                                    SizedBox(width: screenWidth * 0.01),
                                    Text(
                                      event['Hospital_name'].toUpperCase(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Text(
                                event['Date Of Event'],
                                style: TextStyle(
                                  color: Color.fromARGB(255, 148, 26, 17),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailPages_admin(event: event),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
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
