import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AmbulanceTrackingScreen extends StatefulWidget {
  const AmbulanceTrackingScreen({super.key});

  @override
  State<AmbulanceTrackingScreen> createState() =>
      _AmbulanceTrackingScreenState();
}

class _AmbulanceTrackingScreenState extends State<AmbulanceTrackingScreen>
    with SingleTickerProviderStateMixin {
  // Controllers
  final TextEditingController _ambulanceNumberController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();

  // Booking / Tracking State
  bool _isBooked = false;
  bool _isLoadingLocation = false;
  double _progress = 0.0; // 0 to 1
  int _etaMinutes = 12;
  int _distanceKm = 8;
  String _status = "Ambulance Assigned";
  Timer? _trackingTimer;
  late AnimationController _pulseController;

  // Fake Driver Details
  final String _driverName = "Ramesh Kumar";
  final String _driverPhone = "98765 43210";
  final String _vehicleNo = "TS 09 AB 1080";

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _trackingTimer?.cancel();
    _pulseController.dispose();
    _ambulanceNumberController.dispose();
    _locationController.dispose();
    _hospitalController.dispose();
    super.dispose();
  }

  // 1. REAL GPS LOCATION
  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please turn ON Location / GPS")),
        );
        setState(() => _isLoadingLocation = false);
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoadingLocation = false);
          return;
        }
      }
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationController.text =
            "Lat: ${pos.latitude.toStringAsFixed(5)}, Lng: ${pos.longitude.toStringAsFixed(5)}";
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() => _isLoadingLocation = false);
    }
  }

  // 2. BOOK + START TRACKING
  void _bookAndStartTracking() {
    if (_locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("First get your Current Location")),
      );
      return;
    }
    setState(() {
      _isBooked = true;
      _progress = 0.0;
      _etaMinutes = 12;
      _distanceKm = 8;
      _status = "Ambulance on the way...";
    });

    // Every 2 seconds ambulance moves closer
    _trackingTimer?.cancel();
    _trackingTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_progress >= 1.0) {
        timer.cancel();
        setState(() {
          _status = "Ambulance Arrived! 🎉";
          _etaMinutes = 0;
          _distanceKm = 0;
        });
        return;
      }
      setState(() {
        _progress += 0.08;
        if (_progress > 1.0) _progress = 1.0;
        _etaMinutes = (12 * (1 - _progress)).ceil();
        _distanceKm = (8 * (1 - _progress)).ceil();
        if (_progress > 0.3) _status = "Ambulance is nearby...";
        if (_progress > 0.7) _status = "Ambulance almost reached!";
        if (_progress >= 1.0) _status = "Ambulance Arrived! 🎉";
      });
    });
  }

  void _cancelBooking() {
    _trackingTimer?.cancel();
    setState(() {
      _isBooked = false;
      _progress = 0.0;
      _status = "Booking Cancelled";
    });
  }

  @override
  Widget build(BuildContext context) {
    // If NOT booked -> Show Booking Form
    if (!_isBooked) {
      return _buildBookingScreen();
    }
    // If Booked -> Show LIVE TRACKING Screen
    return _buildTrackingScreen();
  }

  // ============ BOOKING SCREEN ============
  Widget _buildBookingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Ambulance"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.local_hospital,
                  size: 80, color: Colors.red),
            ),
            const SizedBox(height: 20),
            const Text("Book Emergency Ambulance",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: _ambulanceNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Ambulance Number",
                hintText: "Enter Ambulance / Phone Number",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _locationController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Current Location",
                hintText: "Tap below button",
                prefixIcon: Icon(Icons.my_location, color: Colors.red),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _isLoadingLocation ? null : _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: Text(_isLoadingLocation
                  ? "Fetching..."
                  : "Use My Current Location"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _hospitalController,
              decoration: const InputDecoration(
                labelText: "Destination Hospital",
                prefixIcon: Icon(Icons.local_hospital),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookAndStartTracking,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text("BOOK & TRACK AMBULANCE",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            const Text("Emergency Helpline: 108",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ],
        ),
      ),
    );
  }

  // ============ LIVE TRACKING SCREEN ============
  Widget _buildTrackingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Tracking"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // STATUS BANNER
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green)),
              child: Row(
                children: [
                  ScaleTransition(
                    scale: Tween(begin: 0.8, end: 1.2).animate(
                        CurvedAnimation(
                            parent: _pulseController,
                            curve: Curves.easeInOut)),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(_status,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // MAP LIKE TRACKING BOX
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                children: [
                  // Road Line
                  Center(
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  // Progress Road
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 6,
                      width: (MediaQuery.of(context).size.width - 90) *
                          _progress,
                      margin: const EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  // Hospital - Destination
                  Positioned(
                    right: 20,
                    top: 100,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.local_hospital,
                              color: Colors.red, size: 32),
                        ),
                        const Text("YOU",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  // Ambulance - Moving
                  Positioned(
                    left: 20 +
                        (MediaQuery.of(context).size.width - 140) * _progress,
                    top: 100,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: const Icon(Icons.local_hospital,
                              color: Colors.white, size: 28),
                        ),
                        const Text("AMBULANCE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ],
                    ),
                  ),
                  // Distance Label
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "$_distanceKm km away • $_etaMinutes min ETA",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ETA + DISTANCE CARDS
            Row(
              children: [
                Expanded(child: _infoCard("ETA", "$_etaMinutes min", Icons.timer, Colors.blue)),
                const SizedBox(width: 12),
                Expanded(child: _infoCard("Distance", "$_distanceKm km", Icons.route, Colors.orange)),
                const SizedBox(width: 12),
                Expanded(child: _infoCard("Progress", "${(_progress * 100).toInt()}%", Icons.trending_up, Colors.green)),
              ],
            ),
            const SizedBox(height: 16),

            // PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 10,
                backgroundColor: Colors.grey.shade200,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
            const SizedBox(height: 16),

            // DRIVER CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 1)
                  ]),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_driverName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Vehicle: $_vehicleNo"),
                        Text("Phone: $_driverPhone"),
                        Text("Location: ${_locationController.text}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call, color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CANCEL BUTTON
            OutlinedButton(
              onPressed: _cancelBooking,
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text("Cancel Booking"),
            ),
            const SizedBox(height: 10),
            Text(
              "Ambulance No: ${_ambulanceNumberController.text} • Hospital: ${_hospitalController.text}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}