import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/create_project_controller.dart';
import '../widgets/create_project_header.dart';
import '../widgets/create_project_primary_button.dart';

class CreateProjectLocationMapScreen extends StatefulWidget {
  final CreateProjectController controller;

  const CreateProjectLocationMapScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CreateProjectLocationMapScreen> createState() =>
      _CreateProjectLocationMapScreenState();
}

class _CreateProjectLocationMapScreenState
    extends State<CreateProjectLocationMapScreen> {
  GoogleMapController? _mapController;
  bool _hasCenteredOnUser = false;
  LatLng? _tempSelectedLatLng;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerUpdate);
    _mapController?.dispose();
    super.dispose();
  }

  void _handleControllerUpdate() {
    final selected = widget.controller.selectedLatLng;
    LatLng? nextTemp = _tempSelectedLatLng;
    if (selected != null) {
      nextTemp = selected;
      _moveCamera(selected);
    } else {
      final target = widget.controller.currentLatLng;
      if (target != null) {
        nextTemp ??= target;
        if (!_hasCenteredOnUser && _mapController != null) {
          _hasCenteredOnUser = true;
          _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(target, 16),
          );
        }
      }
    }

    if (nextTemp != _tempSelectedLatLng && mounted) {
      setState(() {
        _tempSelectedLatLng = nextTemp;
      });
    }
  }

  void _moveCamera(LatLng target) {
    if (_mapController == null) return;
    _mapController!.animateCamera(CameraUpdate.newLatLng(target));
  }

  void _handleSelection(LatLng latLng) {
    setState(() {
      _tempSelectedLatLng = latLng;
    });
    _moveCamera(latLng);
  }

  Future<void> _confirmSelection() async {
    final selected = _tempSelectedLatLng;
    if (selected == null) return;
    await widget.controller.updateSelectedLocation(selected);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CreateProjectHeader(title: 'حدد الموقع على الخريطة'),
              SizedBox(height: 12.h),
              Expanded(
                child: AnimatedBuilder(
                  animation: widget.controller,
                  builder: (context, _) {
                    final selected = _tempSelectedLatLng ??
                        widget.controller.selectedLatLng ??
                        widget.controller.currentLatLng;
                    if (selected == null) {
                      return Center(
                        child: widget.controller.isFetchingLocation
                            ? const CircularProgressIndicator()
                            : Text(
                                widget.controller.locationError ??
                                    'تعذر تحميل الخريطة',
                                style: AppTextStyles.caption12.copyWith(
                                  color: AppColor.orange900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      );
                    }

                    final markers = <Marker>{
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: selected,
                        draggable: true,
                        onDragEnd: _handleSelection,
                      ),
                    };

                    return Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: selected,
                            zoom: 16,
                          ),
                          mapType: MapType.normal,
                          onMapCreated: (controller) {
                            _mapController = controller;
                            _handleControllerUpdate();
                          },
                          myLocationEnabled:
                              widget.controller.hasLocationPermission,
                          myLocationButtonEnabled: false,
                          markers: markers,
                          onTap: _handleSelection,
                        ),
                        if (widget.controller.isFetchingLocation)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                child: CreateProjectPrimaryButton(
                  label: 'تأكيد الموقع',
                  onPressed: _tempSelectedLatLng == null
                      ? null
                      : _confirmSelection,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
