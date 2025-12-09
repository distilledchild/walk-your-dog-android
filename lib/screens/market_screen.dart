import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool _isMapView = true; // Toggle state
  
  // Google Map
  final GoogleMapController? _mapController = null;
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962), // Default location
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color kPaleYellowBg = const Color(0xFFF9F8D0);
    final Color kDarkGreen = const Color(0xFF4A6559);
    final Color kLimeGreen = const Color(0xFFAED581);

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      body: Column(
        children: [
          // 1. Header
          IslandHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Marketplace",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFFF9C4),
                        fontFamily: 'Roboto',
                      ),
                    ),

                    const SizedBox(height: 2),
                    
                    Text(
                      "Find dog items near you",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // Toggle Button
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      _buildToggleButton(
                        icon: Icons.location_on_outlined,
                        isActive: _isMapView,
                        onTap: () => setState(() => _isMapView = true),
                        activeColor: kLimeGreen,
                      ),
                      _buildToggleButton(
                        icon: Icons.format_list_bulleted,
                        isActive: !_isMapView,
                        onTap: () => setState(() => _isMapView = false),
                        activeColor: kLimeGreen,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Content
          Expanded(
            child: _isMapView ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    required Color activeColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF2D3E2E) : Colors.white.withValues(alpha: 0.6),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildMapView() {
    return Column(
      children: [
        const SizedBox(height: 20),
        // Map Container Mockup
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF2D3E2E), // Dark map background
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kInitialPosition,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  // _mapController = controller; 
                },
                markers: {
                  // Example Markers
                   const Marker(
                    markerId: MarkerId("item1"),
                    position: LatLng(37.42796133580664, -122.088),
                    infoWindow: InfoWindow(title: "Dog Leash"),
                  ),
                   const Marker(
                    markerId: MarkerId("item2"),
                    position: LatLng(37.425, -122.085),
                    infoWindow: InfoWindow(title: "Dog Toys"),
                  ),
                },
              ),
            ),
          ),
        ),
        
        // Bottom List Preview
        Container(
          height: 240, // Height for "Items nearby" + Cards
          width: double.infinity,
          decoration: const BoxDecoration(
           color: Color(0xFFF9F8D0), // Match bg for smooth look
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Text(
                  "4 items nearby",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF556B55),
                  ),
                ),
              ),
              // Horizontal List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildItemCard(
                      title: "Dog Leash - Premium",
                      price: "₩15,000",
                      imageAsset: "assets/images/onboard1.png",
                    ),
                    _buildItemCard(
                      title: "Dog Toys Set",
                      price: "₩25,000",
                      imageAsset: "assets/images/onboard2.png",
                    ),
                    _buildItemCard(
                      title: "Dog Food - Organic",
                      price: "₩40,000",
                      imageAsset: "assets/images/onboard3.png",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapMarker({
    required double top,
    double? left,
    double? right,
    required IconData icon,
    required Color color,
    required IconData itemIcon,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(itemIcon, color: Colors.white, size: 20),
          ),
          // Triangle pointer (simple CSS hack equivalent)
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              width: 10,
              height: 8,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard({
    required String title,
    required String price,
    required String imageAsset,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3E2E), // Dark Green
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7CB342), // Green
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildListItem(
          title: "Dog Bowl Set",
          price: "₩12,000",
          distance: "0.5 km away",
          imageAsset: "assets/images/onboard1.png",
        ),
        const SizedBox(height: 16),
        _buildListItem(
          title: "Dog Leash - Premium",
          price: "₩15,000",
          distance: "0.8 km away",
          imageAsset: "assets/images/onboard2.png",
        ),
        const SizedBox(height: 16),
        _buildListItem(
          title: "Dog Toys Set",
          price: "₩25,000",
          distance: "1.2 km away",
          imageAsset: "assets/images/onboard3.png",
        ),
        const SizedBox(height: 16),
        _buildListItem(
          title: "Dog Clothes - Winter",
          price: "₩35,000",
          distance: "1.8 km away",
          imageAsset: "assets/images/onboard1.png",
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildListItem({
    required String title,
    required String price,
    required String distance,
    required String imageAsset,
  }) {
    return Container(
      height: 120, // Clean fixed height for list items
      decoration: BoxDecoration(
        color: const Color(0xFFFEFDE7), // Light cream card bg
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage(imageAsset),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3E2E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7CB342), // Green price
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Color(0xFF556B55),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        distance,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF556B55),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Chat Button
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              height: 40,
              width: 80, // Fixed width button
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFDD835), // Yellow
                    Color(0xFF8BC34A), // Lime Green
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // Chat action
                  },
                  child: const Center(
                    child: Text(
                      "Chat",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3E2E),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const double gridSize = 40;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
