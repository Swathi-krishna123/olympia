import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/view/admin/attendencehistory.dart';

class DatesListPage extends StatefulWidget {
  const DatesListPage({super.key});

  @override
  _DatesListPageState createState() => _DatesListPageState();
}

class _DatesListPageState extends State<DatesListPage> {
  // Sample data: list of dates with their confirmation status
  List<Map<String, dynamic>> dates = [
    {'date': '2024-09-10', 'confirmed': false},
    {'date': '2024-09-09', 'confirmed': false},
    {'date': '2024-09-08', 'confirmed': false},
    {'date': '2024-09-07', 'confirmed': false},
  ];

  void _updateConfirmationStatus(String date, bool confirmed) {
    setState(() {
      final index = dates.indexWhere((d) => d['date'] == date);
      if (index != -1) {
        dates[index]['confirmed'] = confirmed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        title: Text('Dates List', style: Appfonts.headline),
      ),
      body: ListView.builder(
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final dateInfo = dates[index];
          return ListTile(
            title: Text(dateInfo['date']),
            trailing: Text(
              dateInfo['confirmed'] ? '' : 'Not Confirmed',
              style: TextStyle(
                color: dateInfo['confirmed'] ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AttendanceHistoryPage(
                    date: dateInfo['date'],
                    onConfirmation: (bool confirmed) {
                      _updateConfirmationStatus(dateInfo['date'], confirmed);
                    },
                  ),
                ),
              ).then((_) {
                // Optional: You can refresh the page after returning from the details page
                // _refreshData();
              });
            },
          );
        },
      ),
    );
  }
}
