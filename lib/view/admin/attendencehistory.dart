import 'package:flutter/material.dart';
import 'package:olympia/constants/fonts.dart';

class AttendanceHistoryPage extends StatefulWidget {
  final String date;
  final Function(bool) onConfirmation;

  const AttendanceHistoryPage({
    super.key,
    required this.date,
    required this.onConfirmation,
  });

  @override
  _AttendanceHistoryPageState createState() => _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  bool confirmed = false;

  @override
  void initState() {
    super.initState();
    // Initialize confirmed status if needed
    // For simplicity, assuming initial status is false
  }

  void confirmAttendance() {
    setState(() {
      confirmed = true;
      Navigator.pop(context);
    });
    widget.onConfirmation(true); // Notify parent about the confirmation
  }

  @override
  Widget build(BuildContext context) {
    // Sample data: list of attendance records for the selected date
    List<Map<String, dynamic>> attendanceHistory = [
      {'name': 'John Doe', 'attendance': 'Present'},
      {'name': 'Jane Smith', 'attendance': 'Absent'},
      {'name': 'Alex Johnson', 'attendance': 'Present'},
      {'name': 'Emily Brown', 'attendance': 'Present'},
    ];


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        title: Text(widget.date,
            style: Appfonts.headline),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: attendanceHistory.length,
                itemBuilder: (context, index) {
                  final record = attendanceHistory[index];
                  return ListTile(
                    title: Text(record['name']),
                    trailing: DropdownButton<String>(
                      value: record['attendance'],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            attendanceHistory[index]['attendance'] = newValue;
                          });
                        }
                      },
                      items: <String>['Present', 'Absent']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: confirmed ? null : confirmAttendance,
              child: Text(confirmed ? 'Confirmed' : 'Confirm'),
              style: ElevatedButton.styleFrom(
                foregroundColor: confirmed ? Colors.grey : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
