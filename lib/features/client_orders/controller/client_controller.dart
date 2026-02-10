import 'package:flutter/material.dart';
import '../model/order_vm.dart';
import '../model/stage_vm.dart';
import '../view/project_dashboard_screen.dart';

class ClientController extends ChangeNotifier {
  /// 0 = نشط, 1 = قيد الانتظار, 2 = مكتمل
  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  void setTab(int index) {
    if (index == _selectedTabIndex) return;
    _selectedTabIndex = index;
    notifyListeners();
  }

  void openDashboard(BuildContext context, OrderVM order) {
    final stages = buildStages(order.projectTypeKey);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDashboardScreen(
          projectName: order.projectName,
          progressPercent: order.progressPercent,
          stages: stages,
        ),
      ),
    );
  }

  List<StageVM> buildStages(String projectTypeKey) {
    switch (projectTypeKey) {
      case 'fullBuild':
        return _buildFullBuildStages();
      case 'electricity':
        return _buildElectricityStages();
      case 'plumbing':
        return _buildPlumbingStages();
      case 'decorFinishing':
        return _buildDecorFinishingStages();
      case 'foundations':
        return _buildFoundationsStages();
      default:
        return _buildFullBuildStages();
    }
  }

  List<StageVM> _buildFullBuildStages() {
    return [
      const StageVM(
        title: 'الأساسات',
        order: 1,
        status: StageStatus.completed,
        dateText: '25/10',
        remainingDays: 0,
        actionText: 'عرض التقرير',
      ),
      const StageVM(
        title: 'الهيكل الإنشائي',
        order: 2,
        status: StageStatus.completed,
        dateText: '27/10',
        remainingDays: 0,
        actionText: 'عرض التقرير',
      ),
      const StageVM(
        title: 'التمديدات الكهربائية',
        order: 3,
        status: StageStatus.completed,
        dateText: '29/10',
        remainingDays: 0,
        actionText: 'عرض التقرير',
      ),
      const StageVM(
        title: 'التشطيبات الخارجية',
        order: 4,
        status: StageStatus.inProgress,
        dateText: '30/10',
        remainingDays: 23,
        actionText: 'عرض التقرير',
      ),
      const StageVM(
        title: 'التسليم',
        order: 5,
        status: StageStatus.waiting,
        dateText: '15/11',
        remainingDays: 56,
        actionText: 'طلب تقرير',
      ),
    ];
  }

  List<StageVM> _buildElectricityStages() {
    return [
      const StageVM(title: 'معاينة الموقع', order: 1, status: StageStatus.completed, dateText: '20/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'تمديدات داخلية', order: 2, status: StageStatus.completed, dateText: '25/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'تركيب اللوحة والقواطع', order: 3, status: StageStatus.inProgress, dateText: '28/10', remainingDays: 25, actionText: 'عرض التقرير'),
      const StageVM(title: 'اختبار وتشغيل', order: 4, status: StageStatus.waiting, dateText: '10/11', remainingDays: 45, actionText: 'طلب تقرير'),
      const StageVM(title: 'تسليم', order: 5, status: StageStatus.waiting, dateText: '15/11', remainingDays: 50, actionText: 'طلب تقرير'),
    ];
  }

  List<StageVM> _buildPlumbingStages() {
    return [
      const StageVM(title: 'معاينة الموقع', order: 1, status: StageStatus.completed, dateText: '22/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'تمديدات التغذية والصرف', order: 2, status: StageStatus.completed, dateText: '26/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'تركيب الأدوات الصحية', order: 3, status: StageStatus.inProgress, dateText: '29/10', remainingDays: 24, actionText: 'عرض التقرير'),
      const StageVM(title: 'اختبار ضغط وتسريب', order: 4, status: StageStatus.waiting, dateText: '12/11', remainingDays: 48, actionText: 'طلب تقرير'),
      const StageVM(title: 'تسليم', order: 5, status: StageStatus.waiting, dateText: '18/11', remainingDays: 54, actionText: 'طلب تقرير'),
    ];
  }

  List<StageVM> _buildDecorFinishingStages() {
    return [
      const StageVM(title: 'معاينة وقياسات', order: 1, status: StageStatus.completed, dateText: '18/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'تصميم واعتماد', order: 2, status: StageStatus.completed, dateText: '24/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'تنفيذ', order: 3, status: StageStatus.inProgress, dateText: '28/10', remainingDays: 26, actionText: 'عرض التقرير'),
      const StageVM(title: 'مراجعة جودة', order: 4, status: StageStatus.waiting, dateText: '14/11', remainingDays: 52, actionText: 'طلب تقرير'),
      const StageVM(title: 'تسليم', order: 5, status: StageStatus.waiting, dateText: '20/11', remainingDays: 58, actionText: 'طلب تقرير'),
    ];
  }

  List<StageVM> _buildFoundationsStages() {
    return [
      const StageVM(title: 'حفر وتجهيز', order: 1, status: StageStatus.completed, dateText: '23/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'عزل وقواعد', order: 2, status: StageStatus.completed, dateText: '26/10', remainingDays: 0, actionText: 'عرض التقرير'),
      const StageVM(title: 'صب', order: 3, status: StageStatus.inProgress, dateText: '30/10', remainingDays: 22, actionText: 'عرض التقرير'),
      const StageVM(title: 'معالجة وفحص', order: 4, status: StageStatus.waiting, dateText: '11/11', remainingDays: 46, actionText: 'طلب تقرير'),
      const StageVM(title: 'تسليم', order: 5, status: StageStatus.waiting, dateText: '16/11', remainingDays: 51, actionText: 'طلب تقرير'),
    ];
  }

  final List<OrderVM> activeOrders = [
    OrderVM(
      id: '1',
      orderId: '1',
      projectId: 'p1',
      title: 'بناء فيلا سكنية',
      projectName: 'بناء فيلا سكنية',
      projectTypeKey: 'fullBuild',
      status: OrderStatus.active,
      dateLabel: 'تاريخ التنفيذ',
      dateValue: '2025/11/15',
      personLabel: '',
      personValue: 'محمد عبد العزيز - مقاول',
      price: '850,000 ريال',
      orderNumber: 'BN-2025-1547',
      progressPercent: 75,
    ),
    OrderVM(
      id: '2',
      orderId: '2',
      projectId: 'p2',
      title: 'تصميم داخلي لصالة المعيشة',
      projectName: 'تصميم داخلي لصالة المعيشة',
      projectTypeKey: 'decorFinishing',
      status: OrderStatus.active,
      dateLabel: 'تاريخ التنفيذ',
      dateValue: '2025/11/20',
      personLabel: '',
      personValue: 'أحمد المصمم',
      price: '120,000 ريال',
      orderNumber: 'BN-2025-1548',
      progressPercent: 60,
    ),
  ];

  final List<OrderVM> pendingOrders = [
    OrderVM(
      id: '3',
      orderId: '3',
      projectId: 'p3',
      title: 'ترميم منزل قديم',
      projectName: 'ترميم منزل قديم',
      projectTypeKey: 'fullBuild',
      status: OrderStatus.pending,
      dateLabel: 'تاريخ العرض',
      dateValue: '2025/11/08',
      personLabel: '',
      personValue: 'محمد عبدالعزيز',
      price: 'أكثر من 500,000 ريال',
      orderNumber: 'BN-2025-1521',
      progressPercent: 0,
    ),
  ];

  final List<OrderVM> completedOrders = [
    OrderVM(
      id: '4',
      orderId: '4',
      projectId: 'p4',
      title: 'بناء مجلس خارجي',
      projectName: 'بناء مجلس خارجي',
      projectTypeKey: 'fullBuild',
      status: OrderStatus.completed,
      dateLabel: 'تاريخ الإنهاء',
      dateValue: '2025/10/25',
      personLabel: '',
      personValue: 'مؤسسة العمران',
      price: '50,000 ريال',
      orderNumber: 'BN-2025-1498',
      progressPercent: 100,
    ),
    OrderVM(
      id: '5',
      orderId: '5',
      projectId: 'p5',
      title: 'تركيب واجهات حجرية',
      projectName: 'تركيب واجهات حجرية',
      projectTypeKey: 'fullBuild',
      status: OrderStatus.completed,
      dateLabel: 'تاريخ الإنهاء',
      dateValue: '2025/10/20',
      personLabel: '',
      personValue: 'شركة الواجهات',
      price: '75,000 ريال',
      orderNumber: 'BN-2025-1497',
      progressPercent: 100,
    ),
  ];

  List<OrderVM> get currentOrders {
    switch (_selectedTabIndex) {
      case 0:
        return activeOrders;
      case 1:
        return pendingOrders;
      case 2:
        return completedOrders;
      default:
        return activeOrders;
    }
  }
}
