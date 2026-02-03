import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_bottom_nav.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../controllers/market_controller.dart';
import '../models/product_model.dart';
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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColor.orange900,
          child: Icon(Icons.add, color: Colors.white, size: 28.sp),
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: 2,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MarketScreen()),
              );
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
                            SvgPicture.asset(
                              'assets/icons/Filter.svg',
                              width: 24.w,
                              height: 24.h,
                              colorFilter: ColorFilter.mode(
                                AppColor.grey400,
                                BlendMode.srcIn,
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
                          children: [
                            CategoryChip(
                              label: 'الكل',
                              isActive: controller.selectedCategory == 'الكل',
                              onTap: () => controller.selectCategory('الكل'),
                            ),
                            SizedBox(width: 10.w),
                            CategoryChip(
                              label: ProductCategory.iron.labelAr,
                              isActive: controller.selectedCategory ==
                                  ProductCategory.iron.labelAr,
                              onTap: () => controller
                                  .selectCategory(ProductCategory.iron.labelAr),
                            ),
                            SizedBox(width: 10.w),
                            CategoryChip(
                              label: ProductCategory.wood.labelAr,
                              isActive: controller.selectedCategory ==
                                  ProductCategory.wood.labelAr,
                              onTap: () => controller
                                  .selectCategory(ProductCategory.wood.labelAr),
                            ),
                            SizedBox(width: 10.w),
                            CategoryChip(
                              label: ProductCategory.tile.labelAr,
                              isActive: controller.selectedCategory ==
                                  ProductCategory.tile.labelAr,
                              onTap: () => controller
                                  .selectCategory(ProductCategory.tile.labelAr),
                            ),
                            SizedBox(width: 10.w),
                            CategoryChip(
                              label: ProductCategory.other.labelAr,
                              isActive: controller.selectedCategory ==
                                  ProductCategory.other.labelAr,
                              onTap: () => controller
                                  .selectCategory(ProductCategory.other.labelAr),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(24.w, 0, 24.w, 110.h),
                      child: GridView.builder(
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
                          return ProductCard(
                            product: product,
                            onFavoriteTap: () =>
                                controller.toggleFavorite(product.id),
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
