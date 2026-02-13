import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_bottom_nav.dart';
import '../../../core/routing/routes.dart';
import '../controllers/market_controller.dart';
import '../models/product_model.dart';
import '../product_details/models/product_details_model.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late final MarketController controller;

  @override
  void initState() {
    super.initState();
    controller = MarketController();
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _openProductDetails(ProductModel product) {
    Navigator.pushNamed(
      context,
      Routes.productDetails,
      arguments: ProductDetailsModel(
        productId: product.id,
        title: product.title,
        categoryLabel: product.category.labelAr,
        description: product.description,
        stockQtyNullable: product.stockQty,
        city: product.city.isEmpty ? 'الرياض' : product.city,
        price: product.price,
        imageUrl: product.imageUrl,
        sellerNameNullable: product.sellerName,
        sellerRole: 'مقاول معتمد',
        sellerAvatar: 'assets/icons/avatar.png',
      ),
    );
  }

  void _openFilterSheet(BuildContext context) {
    final minController = TextEditingController(
      text: controller.minPrice == null
          ? ''
          : controller.minPrice!.toStringAsFixed(0),
    );
    final maxController = TextEditingController(
      text: controller.maxPrice == null
          ? ''
          : controller.maxPrice!.toStringAsFixed(0),
    );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return DraggableScrollableSheet(
              initialChildSize: 0.85,
              minChildSize: 0.45,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        top: 20.h,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('تصفية المنتجات', style: AppTextStyles.sectionTitle),
                          SizedBox(height: 16.h),
                          Text('ترتيب حسب', style: AppTextStyles.body),
                          SizedBox(height: 8.h),
                          _SortOptionTile(
                            label: SortOption.newest.labelAr,
                            isSelected: controller.sortOption == SortOption.newest,
                            onTap: () => controller.setSortOption(SortOption.newest),
                          ),
                          _SortOptionTile(
                            label: SortOption.priceLowHigh.labelAr,
                            isSelected:
                                controller.sortOption == SortOption.priceLowHigh,
                            onTap: () =>
                                controller.setSortOption(SortOption.priceLowHigh),
                          ),
                          _SortOptionTile(
                            label: SortOption.priceHighLow.labelAr,
                            isSelected:
                                controller.sortOption == SortOption.priceHighLow,
                            onTap: () =>
                                controller.setSortOption(SortOption.priceHighLow),
                          ),
                          _SortOptionTile(
                            label: SortOption.ratingHigh.labelAr,
                            isSelected: controller.sortOption == SortOption.ratingHigh,
                            onTap: () =>
                                controller.setSortOption(SortOption.ratingHigh),
                          ),
                          SizedBox(height: 12.h),
                          Text('نطاق السعر', style: AppTextStyles.body),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: _PriceField(
                                  label: 'من',
                                  controller: minController,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _PriceField(
                                  label: 'إلى',
                                  controller: maxController,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text('أقل تقييم', style: AppTextStyles.body),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 12.w,
                            runSpacing: 12.h,
                            children: [
                              _RatingChip(
                                label: '3+',
                                value: 3,
                                isActive: controller.minRating == 3,
                                onTap: () => controller.setMinRating(3),
                              ),
                              _RatingChip(
                                label: '4+',
                                value: 4,
                                isActive: controller.minRating == 4,
                                onTap: () => controller.setMinRating(4),
                              ),
                              _RatingChip(
                                label: '4.5+',
                                value: 4.5,
                                isActive: controller.minRating == 4.5,
                                onTap: () => controller.setMinRating(4.5),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text('الفئات', style: AppTextStyles.body),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 12.w,
                            runSpacing: 12.h,
                            children: controller.categories
                                .map(
                                  (category) => CategoryChip(
                                    label: category.label,
                                    isActive:
                                        controller.selectedCategoryId == category.id,
                                    onTap: () => controller.setCategory(category.id),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    controller.clearFilters();
                                    minController.clear();
                                    maxController.clear();
                                    Navigator.pop(sheetContext);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: AppColor.orange900),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 14.h),
                                  ),
                                  child: Text(
                                    'مسح',
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColor.orange900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.setPriceRangeFromText(
                                      minController.text,
                                      maxController.text,
                                    );
                                    Navigator.pop(sheetContext);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.orange900,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 14.h),
                                  ),
                                  child: Text(
                                    'تطبيق',
                                    style: AppTextStyles.body.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.addProduct);
          },
          backgroundColor: AppColor.orange900,
          child: Icon(Icons.add, color: Colors.white, size: 28.sp),
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: 2,
          onTap: (index) {
            if (index == 2) return;
            if (index == 0) {
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
              return;
            }
            if (index == 3) {
              Navigator.pushReplacementNamed(context, Routes.messagesScreen);
              return;
            }
            if (index == 1) {
              // TODO: OrdersScreen route
              Navigator.pushReplacementNamed(context, Routes.clientOrdersScreen);
              return;
            }
            if (index == 4) {
              Navigator.pushNamed(context, Routes.profileSettingsScreen);
              return;
            }
          },
        ),
        body: SafeArea(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      'السوق',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title,
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 18.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.grey100,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => _openFilterSheet(context),
                              borderRadius: BorderRadius.circular(24.r),
                              child: SvgPicture.asset(
                                'assets/icons/Filter.svg',
                                width: 24.w,
                                height: 24.h,
                                colorFilter: ColorFilter.mode(
                                  AppColor.grey400,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: TextField(
                                onChanged: controller.updateSearch,
                                textAlign: TextAlign.right,
                                style: AppTextStyles.body,
                                decoration: InputDecoration(
                                  hintText: 'ابحث عن منتج أو فئة…',
                                  hintStyle: AppTextStyles.body.copyWith(
                                    color: AppColor.grey400,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            SvgPicture.asset(
                              'assets/icons/Search.svg',
                              width: 24.w,
                              height: 24.h,
                              colorFilter: ColorFilter.mode(
                                AppColor.grey400,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.categories
                              .expand((category) => [
                                    CategoryChip(
                                      label: category.label,
                                      isActive:
                                          controller.selectedCategoryId == category.id,
                                      onTap: () => controller.setCategory(category.id),
                                    ),
                                    SizedBox(width: 10.w),
                                  ])
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(24.w, 0, 24.w, 110.h),
                      child: controller.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : controller.error != null
                              ? Center(
                                  child: Text(
                                    'تعذر تحميل المنتجات',
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColor.grey600,
                                    ),
                                  ),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.filteredProducts.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 16.h,
                                    childAspectRatio: 0.58,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product = controller.filteredProducts[index];
                                    return GestureDetector(
                                      onTap: () => _openProductDetails(product),
                                      child: ProductCard(
                                        product: product,
                                        onFavoriteTap: () =>
                                            controller.toggleFavorite(product.id),
                                      ),
                                    );
                                  },
                                ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SortOptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortOptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.orange900, width: 1),
                color: isSelected ? AppColor.orange900 : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 6.w,
                        height: 6.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: AppTextStyles.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _PriceField({
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      textAlign: TextAlign.right,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: AppTextStyles.body.copyWith(color: AppColor.grey400),
        filled: true,
        fillColor: AppColor.grey100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.orange900),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  final String label;
  final double value;
  final bool isActive;
  final VoidCallback onTap;

  const _RatingChip({
    required this.label,
    required this.value,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38.h,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          color: isActive ? AppColor.orange900 : Colors.transparent,
          border: Border.all(color: AppColor.orange900, width: 0.5),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : AppColor.orange900,
            ),
          ),
        ),
      ),
    );
  }
}
