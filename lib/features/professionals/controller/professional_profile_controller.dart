import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../home/model/professional_vm.dart';
import '../model/professional_product_vm.dart';
import '../model/professional_work_vm.dart';
import '../model/professional_review_vm.dart';

class ProfessionalProfileController extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  ProfessionalVm? _professional;
  bool _disposed = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  ProfessionalVm? get professional => _professional;

  void _safeNotify() {
    if (_disposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Dummy works list for UI (matches screenshot).
  static final List<ProfessionalWorkVm> dummyWorks = [
    const ProfessionalWorkVm(
      id: 'w1',
      title: 'برج إداري',
      city: 'الرياض',
    ),
    const ProfessionalWorkVm(
      id: 'w2',
      title: 'فيلا سكنية فاخرة',
      city: 'الدمام',
    ),
    const ProfessionalWorkVm(
      id: 'w3',
      title: 'مجمع سكني متكامل',
      city: 'الرياض',
    ),
  ];

  /// Dummy products list for UI (matches screenshot).
  static final List<ProfessionalProductVm> dummyProducts = [
    const ProfessionalProductVm(
      id: 'p1',
      name: 'كنبة غيمة',
      companyName: 'شركة الفا للتصميم',
      price: '100 ريال',
    ),
    const ProfessionalProductVm(
      id: 'p2',
      name: 'ابجوره',
      companyName: 'شركة الفا للتصميم',
      price: '200 ريال',
    ),
  ];

  /// Dummy reviews list for UI (matches screenshot).
  static final List<ProfessionalReviewVm> dummyReviews = [
    const ProfessionalReviewVm(
      id: 'r1',
      reviewerName: 'نورة العتيبي',
      timeLabel: 'منذ يومين',
      starCount: 4,
      comment: 'تعامل ممتاز وجودة عالية في التنفيذ.',
    ),
    const ProfessionalReviewVm(
      id: 'r2',
      reviewerName: 'صالح أحمد',
      timeLabel: 'منذ أسبوعين',
      starCount: 5,
      comment: 'خدمة متميزة وتنفيذ سريع.',
    ),
    const ProfessionalReviewVm(
      id: 'r3',
      reviewerName: 'فاطمة الدوسري',
      timeLabel: 'منذ شهر',
      starCount: 5,
      comment: 'التزام تام بالمواعيد والمواصفات.',
    ),
  ];

  List<ProfessionalWorkVm> get works => List.unmodifiable(dummyWorks);
  List<ProfessionalProductVm> get products => List.unmodifiable(dummyProducts);
  List<ProfessionalReviewVm> get reviews => List.unmodifiable(dummyReviews);

  Future<void> loadProfessional(String id) async {
    _isLoading = true;
    _error = null;
    _professional = null;
    _safeNotify();

    try {
      final response = await Supabase.instance.client
          .from('professional_profiles')
          .select('id,type,display_name,bio,city,logo_url')
          .eq('id', id)
          .maybeSingle();

      if (_disposed) return;
      if (response != null) {
        _professional = ProfessionalVm.fromJson(response);
        _error = null;
      } else {
        _error = 'لم يتم العثور على الملف';
      }
    } catch (e) {
      if (_disposed) return;
      _error = e.toString();
      _professional = null;
    } finally {
      if (!_disposed) {
        _isLoading = false;
        _safeNotify();
      }
    }
  }
}
