import 'package:flutter/material.dart';
import '../models/product_details_model.dart';

class ProductDetailsController extends ChangeNotifier {
  final ProductDetailsModel product;

  ProductDetailsController({ProductDetailsModel? product})
      : product = product ??
            const ProductDetailsModel(
              title: 'سقالات كورية متكاملة',
              categoryLabel: 'سقالات',
              description:
                  'سقالات كورية متكاملة بجودة عالية وسهولة في التركيب، مناسبة لجميع أنواع المشاريع الإنشائية.',
              quantityLabel: '10 قطع',
              city: 'الرياض',
              priceLabel: '300 ريال',
              imageUrl: 'assets/images/ImageWithFallback2.png',
              sellerName: 'محمد خالد',
              sellerRole: 'مقاول معتمد',
              sellerAvatar: 'assets/icons/avatar.png',
            );
}
