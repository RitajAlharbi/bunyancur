import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/theme/app_colors.dart';

class MapPreviewSection extends StatefulWidget {
  final String? location;
  final String? projectImagePath;

  const MapPreviewSection({
    super.key,
    this.location,
    this.projectImagePath,
  });

  @override
  State<MapPreviewSection> createState() => _MapPreviewSectionState();
}

class _MapPreviewSectionState extends State<MapPreviewSection> {
  GoogleMapController? _mapController;
  LatLng? _location;
  bool _locationPermissionRequested = false;

  @override
  void initState() {
    super.initState();
    _parseLocation();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    if (_locationPermissionRequested) return;
    _locationPermissionRequested = true;
    await Permission.locationWhenInUse.request();
  }

  void _parseLocation() {
    if (widget.location != null && widget.location!.isNotEmpty) {
      final parts = widget.location!.split(',');
      if (parts.length == 2) {
        final lat = double.tryParse(parts[0].trim());
        final lng = double.tryParse(parts[1].trim());
        if (lat != null && lng != null) {
          _location = LatLng(lat, lng);
        }
      }
    }
    // Default to Riyadh if no location provided
    _location ??= const LatLng(24.7136, 46.6753);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            'الموقع',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.orange900,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: _location != null
                ? Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _location!,
                          zoom: 15.0,
                        ),
                        markers: {},
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                        },
                      ),
                      // Custom pin overlay positioned at center
                      Center(
                        child: _MapPinWithImage(imagePath: widget.projectImagePath),
                      ),
                    ],
                  )
                : Container(
                    color: const Color(0xFFE8EAED),
                    child: Center(
                      child: Icon(
                        Icons.map,
                        size: 48.sp,
                        color: AppColor.grey400,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

class _MapPinWithImage extends StatelessWidget {
  final String? imagePath;

  const _MapPinWithImage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pin tail (pointed bottom)
        CustomPaint(
          size: Size(24.w, 40.h),
          painter: _PinTailPainter(),
        ),
        // Pin head (circular with building image)
        Positioned(
          top: 0,
          child: Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColor.orange900,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: imagePath != null
                    ? (imagePath!.startsWith('http') || imagePath!.startsWith('https')
                        ? Image.network(
                            imagePath!,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (_, __, ___) => _fallbackIcon(),
                          )
                        : Image.asset(
                            imagePath!,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (_, __, ___) => _fallbackIcon(),
                          ))
                    : _fallbackIcon(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fallbackIcon() => Icon(
        Icons.business,
        size: 24.sp,
        color: AppColor.white,
      );
}

class _PinTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.orange900
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(size.width / 2 - 8, size.height - 12)
      ..lineTo(size.width / 2 + 8, size.height - 12)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
