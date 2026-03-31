import 'package:flutter/material.dart';
import 'package:flutter_application_1/wallet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'profile.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavIndex = 0;
  bool _hasBooking = true;

  // ── GOOGLE MAP CONTROLLER (from sample code) ──
  late GoogleMapController mapController;
  GoogleMapController? _mapController;

  static const LatLng _userLocation = LatLng(47.9184, 106.9177);
  final LatLng _center = const LatLng(47.9184, 106.9177);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _mapController = controller;
  }

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('user'),
      position: LatLng(47.9184, 106.9177),
      infoWindow: InfoWindow(title: 'Таны байршил'),
    ),
    const Marker(
      markerId: MarkerId('wash1'),
      position: LatLng(47.9150, 106.9100),
      infoWindow: InfoWindow(
        title: 'SparkleWash Downtown',
        snippet: '300m · 20k-30k',
      ),
    ),
    const Marker(
      markerId: MarkerId('wash2'),
      position: LatLng(47.9210, 106.9250),
      infoWindow: InfoWindow(
        title: 'SparkleWash Uptown',
        snippet: '500m · 15k-25k',
      ),
    ),
    const Marker(
      markerId: MarkerId('wash3'),
      position: LatLng(47.9220, 106.9050),
      infoWindow: InfoWindow(
        title: 'AutoShine Pro',
        snippet: '1.2km · 25k',
      ),
    ),
  };

  final List<Map<String, dynamic>> _nearbyPlaces = [
    {
      'name': 'SparkleWash Downtown',
      'address': '123 Khan-Uul, Ulaanbaatar',
      'rating': 4.5,
      'distance': '300m',
      'price': '20k-30k',
      'isOpen': true,
      'hours': '8:00 AM - 9:00 PM',
    },
    {
      'name': 'SparkleWash Uptown',
      'address': '123 Khan-Uul, Ulaanbaatar',
      'rating': 4.5,
      'distance': '300m',
      'price': '20k-30k',
      'isOpen': false,
      'hours': '8:00 AM - 9:00 PM',
    },
    {
      'name': 'AutoShine Pro',
      'address': '123 Khan-Uul, Ulaanbaatar',
      'rating': 4.5,
      'distance': '300m',
      'price': '20k-30k',
      'isOpen': true,
      'hours': '8:00 AM - 9:00 PM',
    },
    {
      'name': 'SparkleWash West',
      'address': '123 Khan-Uul, Ulaanbaatar',
      'rating': 4.5,
      'distance': '300m',
      'price': '20k-30k',
      'isOpen': true,
      'hours': '8:00 AM - 9:00 PM',
    },
    {
      'name': 'SparkleWash East',
      'address': '123 Khan-Uul, Ulaanbaatar',
      'rating': 4.5,
      'distance': '300m',
      'price': '20k-30k',
      'isOpen': true,
      'hours': '8:00 AM - 9:00 PM',
    },
  ];

  void _moveToPlace(LatLng position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── GOOGLE MAP ──
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.5,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: false,
            ),
          ),

          // ── GRADIENT HEADER ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 160,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0072DB),
                    Color(0x000072DB),
                  ],
                ),
              ),
            ),
          ),

          // ── TOP UI (nav + search + booking) ──
          SafeArea(
            child: Column(
              children: [
                _buildTopNav(),
                _buildSearchBar(),
                if (_hasBooking) _buildBookingCard(),
              ],
            ),
          ),

          // ── DRAGGABLE BOTTOM SHEET ──
          DraggableScrollableSheet(
            initialChildSize: 0.28,
            minChildSize: 0.28,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Title
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Text(
                        'Ойрхон байршилууд',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Place list
                    ..._nearbyPlaces
                        .map((place) => _buildPlaceRow(place))
                        .toList(),

                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── TOP NAV ──
  Widget _buildTopNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assets/images/logo1.png", width: 30),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Image.asset("assets/images/logo2.png",
                                  height: 25),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Image.asset("assets/images/logo3.png", width: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _navIconButton(Icons.wallet, 0, onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WalletPage()));
          }),
          const SizedBox(width: 8),
          _navIconButton(Icons.person_outline, 1, onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
          }),
          const SizedBox(width: 8),
          _navIconButton(Icons.description_outlined, 2, onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderPage()));
          }),
        ],
      ),
    );
  }

  Widget _navIconButton(IconData icon, int index, {VoidCallback? onTap}) {
    final isSelected = _selectedNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedNavIndex = index);
        onTap?.call();
      },
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0072DB) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
          size: 22,
        ),
      ),
    );
  }

  // ── SEARCH BAR ──
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search, color: Colors.black, size: 20),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Авто угаалга хайх...',
                style: TextStyle(color: Colors.black38, fontSize: 14),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 30,
              height: 30,
              child: const Icon(Icons.keyboard_arrow_down,
                  color: Colors.black, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  // ── BOOKING CARD ──
  Widget _buildBookingCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0072DB),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0072DB).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.calendar_month,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style:
                            TextStyle(fontSize: 13, color: Colors.white70),
                        children: [
                          TextSpan(text: 'Таны захиалга '),
                          TextSpan(
                            text: 'Маргааш',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'BMW X5 - Signature...',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Fresh Car Wash',
                      style:
                          TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _hasBooking = false),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward,
                    color: Colors.white, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── PLACE ROW ──
  Widget _buildPlaceRow(Map<String, dynamic> place) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.local_car_wash,
                color: Color(0xFF0072DB), size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      place['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xFFFFC107), size: 12),
                          const SizedBox(width: 2),
                          Text(
                            '${place['rating']}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 12, color: Colors.black45),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        place['address'],
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black45),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _tag(
                      place['isOpen']
                          ? '● Open ${place['hours']}'
                          : '● Closed ${place['hours']}',
                      place['isOpen']
                          ? const Color(0xFFE6F9F0)
                          : const Color(0xFFFFEEEE),
                      place['isOpen']
                          ? const Color(0xFF34C759)
                          : Colors.redAccent,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _tag('🔊 ${place['distance']}',
                        const Color(0xFFFFF8E1), Colors.orange),
                    const SizedBox(width: 4),
                    _tag('🖥 ${place['price']}',
                        const Color(0xFFE8F0FE), const Color(0xFF0072DB)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}