import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sih2024/PUBLIC/new2.dart';
class EventsListPagess extends StatefulWidget {
  @override
  _EventsListPagessState createState() => _EventsListPagessState();
}

class _EventsListPagessState extends State<EventsListPagess> {
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
                padding: const EdgeInsets.all(10.0),
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
                    fillColor: const Color.fromARGB(255, 5, 170, 10),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('BEFORE EVENT')
                      .orderBy('Date Of Event', descending: true)
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
  final hospitalName = data['Hospital_name']?.toLowerCase() ?? 'null';
  final program = data['Program']?.toLowerCase() ?? 'null';
  final date = data['Date Of Event']?.toLowerCase() ?? 'null';
  final district = data['District']?.toLowerCase() ?? 'null';
  final subDistrict = data['Sub_District']?.toLowerCase() ?? 'null';
  final state = data['State / Union Territory']?.toLowerCase() ?? 'null';

  // Check if the search query matches any of these fields
  return hospitalName.contains(_searchQuery) ||
         program.contains(_searchQuery) ||
         date.contains(_searchQuery) ||
         district.contains(_searchQuery) ||
         subDistrict.contains(_searchQuery) ||
         state.contains(_searchQuery);
}).toList();


                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            height: 190,
                            child:ListTile(
  contentPadding: EdgeInsets.all(7),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: BorderSide(color: Colors.blueAccent),
  ),
  tileColor: Colors.blue,
  title: Text(
    event['Program'].toUpperCase(),
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    maxLines: 1, // Limit the title to 2 lines
    overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
  ),
  subtitle: Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_pin, color: Colors.green),
            SizedBox(width: screenWidth * 0.01),
            Expanded( // Wrap text to prevent overflow
              child: Text(
                event['Hospital_name'].toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          'District: ${event['District']}'.toUpperCase(),
          style: TextStyle(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'Sub District: ${event['Sub_District']}'.toUpperCase(),
          style: TextStyle(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'State: ${event['State / Union Territory']}'.toUpperCase(),
          style: TextStyle(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
        builder: (context) => EventDetailPages(event: event),
      ),
    );
  },
),

                             /*ListTile(
                              contentPadding: EdgeInsets.all(7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.blueAccent),
                              ),
                              tileColor: Colors.blue,
                              title: Text(
                                event['Program'].toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                 maxLines: 2, 
    overflow: TextOverflow.ellipsis,
                              ),
                              subtitle:/* Padding(
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
                              ),*/ Padding(
  padding: EdgeInsets.all(8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.location_pin, color: Colors.green),
          SizedBox(width: screenWidth * 0.01),
          Text(
            event['Hospital_name'].toUpperCase() ,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      SizedBox(height: 5), // Add some spacing
      Text(
        'District: ${event['District']}'.toUpperCase(),
        style: TextStyle(fontSize: 13),
      ),
      Text(
        'Sub District: ${event['Sub_District']}'.toUpperCase(),
        style: TextStyle(fontSize: 13),
      ),
      Text(
        'State: ${event['State / Union Territory']}'.toUpperCase(),
        style: TextStyle(fontSize: 13),
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
                                    builder: (context) => EventDetailPages(event: event),
                                  ),
                                );
                              },
                            ),*/
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
