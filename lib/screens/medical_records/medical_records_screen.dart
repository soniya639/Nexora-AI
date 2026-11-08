import 'package:flutter/material.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  // Reports - Real Content tho!
  final List<Map<String, String>> reports = const [
    {
      "title": "Blood Test Report.pdf",
      "date": "20 July 2026",
      "details": "Haemoglobin: 13.5\nSugar: 95 (Normal)\nBP: 120/80\nDoctor: All Normal - No Problem",
    },
    {
      "title": "X-Ray Report.pdf",
      "date": "18 July 2026",
      "details": "Chest X-Ray: Normal\nNo Fracture\nNo Infection Found",
    },
    {
      "title": "Prescription Report.pdf",
      "date": "15 July 2026",
      "details": "Medicine: Paracetamol 500mg\nMorning - Night, 3 Days\nDoctor: Dr. Ramesh",
    },
    {
      "title": "New Medical Report.pdf",
      "date": "10 July 2026",
      "details": "General Health Checkup\nAll Reports Normal",
    },
  ];

  // CLICK CHESTE - Ee Function Open Avthundhi!
  void openReport(BuildContext context, Map<String, String> report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(report['title']!),
        content: Text(
          "Date: ${report['date']}\n\n${report['details']}",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CLOSE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Medical Records")),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final r = reports[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.red, size: 32),
              title: Text(r['title']!),
              subtitle: Text("Date: ${r['date']}"),
              trailing: Icon(Icons.visibility),
              // 👇 IDHI MUKHYAM - Click cheste Open Avthundhi!
              onTap: () => openReport(context, r),
            ),
          );
        },
      ),
    );
  }
}