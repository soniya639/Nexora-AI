import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelemedicineScreen extends StatefulWidget {
  const TelemedicineScreen({super.key});
  @override
  createState() {
    return _TelemedicineScreenState();
  }
}

class _TelemedicineScreenState extends State {
  String _search = "";
  String _selectedCity = "All India";

  // Hospital, Doctor, Specialist, Rating, Phone, Website, City
  List _doctors = [
    // DELHI NCR
    ["AIIMS New Delhi", "Dr. A. S. Arora", "Neurologist", "4.8", "01126588500", "https://www.aiims.edu/", "Delhi"],
    ["Medanta Gurugram", "Dr. Naresh Trehan", "Cardiologist", "5.0", "01244141414", "https://www.medanta.org/", "Delhi"],
    ["Apollo Delhi", "Dr. R. V. Pradeep Kumar", "ENT Specialist", "4.9", "01126925858", "https://www.apollohospitals.com/delhi/", "Delhi"],
    ["Max Saket Delhi", "Dr. Rajneesh Malhotra", "Cardiac Surgeon", "4.9", "01146097200", "https://www.maxhealthcare.in/", "Delhi"],
    ["Fortis Gurugram", "Dr. Rana Patir", "Neurosurgeon", "4.9", "01244241414", "https://www.fortishealthcare.com/", "Delhi"],
    // MUMBAI
    ["Tata Memorial Mumbai", "Dr. R. G. Patel", "Oncologist", "4.9", "02224177000", "https://tmc.gov.in/", "Mumbai"],
    ["Kokilaben Mumbai", "Dr. Meera Deshpande", "Gynecologist", "4.8", "02242699999", "https://www.kokilabenhospital.com/", "Mumbai"],
    ["Fortis Mulund Mumbai", "Dr. Anil K. Jain", "Orthopedician", "4.8", "02249254555", "https://www.fortishealthcare.com/", "Mumbai"],
    ["Apollo Navi Mumbai", "Dr. S. L. Bhatia", "Neurologist", "4.9", "02233503350", "https://www.apollohospitals.com/mumbai/", "Mumbai"],
    // CHENNAI
    ["Apollo Chennai", "Dr. Prathap C. Reddy", "Cardiologist", "5.0", "04428290200", "https://www.apollohospitals.com/chennai/", "Chennai"],
    ["MGM Healthcare Chennai", "Dr. K. R. Balakrishnan", "Cardiac Surgeon", "4.9", "04445242424", "https://www.mgmhealthcare.in/", "Chennai"],
    ["Apollo Chennai", "Dr. S. Sundar", "Orthopedician", "4.8", "04428290200", "https://www.apollohospitals.com/chennai/", "Chennai"],
    ["Dr Mohan Chennai", "Dr. V. Mohan", "Diabetologist", "4.9", "04443997777", "https://drmohans.com/", "Chennai"],
    // BENGALURU
    ["Narayana Bengaluru", "Dr. Devi Shetty", "Cardiac Surgeon", "5.0", "08022221111", "https://www.narayanahealth.org/", "Bengaluru"],
    ["Manipal Bengaluru", "Dr. H. Sudarshan Ballal", "Nephrologist", "4.9", "08022221111", "https://www.manipalhospitals.com/", "Bengaluru"],
    ["Fortis Bengaluru", "Dr. Sandeep Nayak", "Surgical Oncologist", "4.9", "08066214444", "https://www.fortishealthcare.com/", "Bengaluru"],
    ["Apollo Bengaluru", "Dr. V. B. Gupta", "Neurologist", "4.8", "08040304050", "https://www.apollohospitals.com/bangalore/", "Bengaluru"],
    // HYDERABAD
    ["Apollo Hyderabad", "Dr. G. R. Reddy", "Cardiologist", "4.9", "04023607777", "https://www.apollohospitals.com/hyderabad/", "Hyderabad"],
    ["KIMS Secunderabad", "Dr. B. Bhaskar Rao", "Cardiac Surgeon", "4.9", "04044885000", "https://www.kimshospitals.com/secunderabad/", "Hyderabad"],
    ["CARE Banjara Hills", "Dr. K. S. Ratnakar", "Neurologist", "4.8", "04068106589", "https://www.carehospitals.com/", "Hyderabad"],
    ["Medicover Hyderabad", "Dr. C. S. Reddy", "Oncologist", "4.8", "04068334455", "https://www.medicoverhospitals.in/", "Hyderabad"],
    // KOLKATA
    ["Apollo Kolkata", "Dr. A. K. Mukherjee", "Cardiologist", "4.8", "03323203040", "https://www.apollohospitals.com/kolkata/", "Kolkata"],
    ["AMRI Kolkata", "Dr. S. K. Todi", "Critical Care", "4.9", "03366800000", "https://www.amrihospitals.in/", "Kolkata"],
    ["Fortis Kolkata", "Dr. R. N. Sarkar", "Neurologist", "4.8", "03366204567", "https://www.fortishealthcare.com/", "Kolkata"],
    // AHMEDABAD
    ["Apollo Ahmedabad", "Dr. Tejas Patel", "Cardiologist", "4.9", "07966701828", "https://www.apollohospitals.com/ahmedabad/", "Ahmedabad"],
    ["Sterling Ahmedabad", "Dr. K. R. Shah", "Orthopedician", "4.8", "07940011111", "https://www.sterlinghospitals.com/", "Ahmedabad"],
    // VIZAG
    ["KIMS Vizag", "Dr. Garikapati Mahesh", "Cardiologist", "4.9", "08912827777", "https://www.kimshospitals.com/seethammadhara/", "Vizag"],
    ["Apollo Vizag", "Dr. Ravi Raju Tatapudi", "Nephrologist", "4.9", "08062972806", "https://www.apollohospitals.com/hospitals/apollo-hospitals-vizag", "Vizag"],
    ["SevenHills Vizag", "Dr. P.M. Jagannath", "Neurosurgeon", "4.9", "08916677777", "https://www.mgmsevenhills.in/", "Vizag"],
    ["CARE Vizag", "Dr. Anil Kumar Gandham", "Pulmonologist", "4.7", "08916165656", "https://www.carehospitals.com/", "Vizag"],
  ];

  List _cities = ["All India", "Delhi", "Mumbai", "Chennai", "Bengaluru", "Hyderabad", "Kolkata", "Ahmedabad", "Vizag"];

  _callNumber(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  _showBookDialog(String hospital, String name, String spec, String phone) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(hospital),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 4),
              Text(spec),
              SizedBox(height: 10),
              Text("Booking kosam call cheyandi:"),
              Text(phone, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _callNumber(phone);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
              child: Text("Call Now"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List filtered = [];
    for (var d in _doctors) {
      bool matchCity = false;
      if (_selectedCity == "All India") {
        matchCity = true;
      } else {
        if (d[6].toLowerCase().contains(_selectedCity.toLowerCase())) {
          matchCity = true;
        }
      }
      bool matchSearch = false;
      if (_search.isEmpty) {
        matchSearch = true;
      } else {
        if (d[0].toLowerCase().contains(_search.toLowerCase()) || d[1].toLowerCase().contains(_search.toLowerCase()) || d[2].toLowerCase().contains(_search.toLowerCase())) {
          matchSearch = true;
        }
      }
      if (matchCity && matchSearch) {
        filtered.add(d);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Telemedicine - All India"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(color: Color(0xFF1A9BE0), borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.video_call, color: Colors.white, size: 32),
                  ),
                  SizedBox(height: 10),
                  Text("AI Telemedicine - All India", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("All Hospitals - All Doctors - One App", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13), textAlign: TextAlign.center),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _search = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search Hospital / Doctor / Specialist",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
              ),
            ),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cities.length,
                itemBuilder: (context, index) {
                  String h = _cities[index];
                  bool isSelected = _selectedCity == h;
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 16 : 6, right: 2),
                    child: ChoiceChip(
                      label: Text(h),
                      selected: isSelected,
                      selectedColor: Colors.teal,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                      onSelected: (val) {
                        setState(() {
                          _selectedCity = h;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text("Available Doctors (${filtered.length}) - $_selectedCity", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            for (var d in filtered)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2))]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HOSPITAL NAME - PAINA PEDDA GA
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.teal.shade100)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_hospital, size: 16, color: Colors.teal),
                          SizedBox(width: 5),
                          Text(d[0], style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.teal.shade800)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(radius: 26, backgroundColor: Colors.blue.shade100, child: Icon(Icons.person, color: Colors.blue, size: 30)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d[1], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text(d[2], style: TextStyle(fontSize: 13, color: Colors.grey)),
                              SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  Text(" ${d[3]}  •  ${d[6]}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.phone, size: 13, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(d[4], style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showBookDialog(d[0], d[1], d[2], d[4]);
                            },
                            icon: Icon(Icons.calendar_today, size: 16),
                            label: Text("Book"),
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.grey.shade700, side: BorderSide(color: Colors.grey.shade300), backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _openLink(d[5]);
                            },
                            icon: Icon(Icons.videocam, size: 18),
                            label: Text("Video Call"),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Prathi card lo: Hospital Name + Doctor Name + Specialist + Rating + Phone + Book + Video Call - anni unnayi. Book kotte hospital ki call, Video Call kotte hospital official website open avthundi.", style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}