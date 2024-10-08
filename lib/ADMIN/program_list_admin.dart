import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import to help with date parsing
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

    return  WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return true;
      },
      child:GestureDetector(
      onTap: _onTapOutside, // Hide keyboard when tapping outside the search bar
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 5, 170, 10),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
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

                    // Sort the events by date in ascending order
                    events.sort((a, b) {
                      final dateA = _parseDate((a.data() as Map<String, dynamic>)['Date Of Event']);
                      final dateB = _parseDate((b.data() as Map<String, dynamic>)['Date Of Event']);
                      return dateA.compareTo(dateB);
                    });

                    return Column(
                      children: events.map((doc) {
                        final event = doc.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 100,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.blueAccent),
                              ),
                              tileColor: Colors.blue,
                              title: Text(
                                event['Program'].toUpperCase(),
                                maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_pin, color: Colors.green),
                                    SizedBox(width: screenWidth * 0.01),
                                    Expanded(
                                      child: Text(
                                        event['Hospital_name'].toUpperCase(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                                            maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                                      ),
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
                                    builder: (context) => EventDetailPages_admin(event: event,program: event['Program'],hospital:event['Hospital_name']),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  // Helper method to parse the date in 'dd/MM/yyyy' format
  DateTime _parseDate(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return DateTime.now(); // Fallback to current date in case of error
    }
  }
}

/*import 'package:flutter/material.dart';
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
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    //fillColor: const Color.fromARGB(255, 157, 205, 245),
                    fillColor: const Color.fromARGB(255, 5, 170, 10)
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
                                overflow:TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_pin, color: Colors.green),
                                    SizedBox(width: screenWidth * 0.01),
                                    Text(
                                      event['Hospital_name'].toUpperCase(),
                                      style: TextStyle( fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),
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
}*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    return GestureDetector(
      onTap: _onTapOutside, // Hide keyboard when tapping outside the search bar
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 5, 170, 10),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
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

                    return Column(
                      children: events.map((doc) {
                        final event = doc.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 100,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.blueAccent),
                              ),
                              tileColor: Colors.blue,
                              title: Text(
                                event['Program'].toUpperCase(),
                                maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_pin, color: Colors.green),
                                    SizedBox(width: screenWidth * 0.01),
                                    Expanded(
                                      child: Text(
                                        event['Hospital_name'].toUpperCase(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                                            maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                                      ),
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
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

