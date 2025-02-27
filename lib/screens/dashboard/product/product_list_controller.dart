import 'dart:developer';

import 'package:get/get.dart';
import 'package:water_customer_app/Models/list_cart_response_model.dart';
import 'package:water_customer_app/Models/product_List_response_model.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;
import 'package:water_customer_app/api/api_manager.dart';

class ProductListController extends GetxController{

  RxList<CartItem> cartList = <CartItem>[].obs;

  RxBool isLoadingCart = false.obs;
  RxBool isLoadingProductList = false.obs;
  ProductListResponseModel? productListResponseModel;
  ListCartResponseModel? listCartResponseModel;
  RxString selectedProductId = ''.obs;


  Future<void> getProductList() async {
    try {
      isLoadingProductList.value = true;
      productListResponseModel = await APIManager.getProductList();
      if (productListResponseModel
      is ProductListResponseModel) {
        print(productListResponseModel?.data);
        isLoadingProductList.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error: $e');
    }
  }
  Future<void> addToCart(String date,String productId,int quantity,double price,) async {
    try {
      isLoadingCart.value = true;
      selectedProductId.value = productId;
      final response = await APIManager.addToCart(date,productId,quantity,price);
      if (response
          == 'Done.') {
        await listTheCart();
        productListResponseModel?.data?.forEach((product) {
          if (product.id == productId) {
            product.isProductInCart.value = true;
          }
        });
        isLoadingCart.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }finally {
      selectedProductId.value = ''; // Reset after API call is complete
      isLoadingCart.value = false;
    }
  }
  Future<void> listTheCart() async {
    try {
      isLoadingCart.value = true;
      listCartResponseModel = await APIManager.listTheCart();
      if (listCartResponseModel
      is ListCartResponseModel) {
        print(listCartResponseModel?.data);
        print('Cart items:');
        for (var item in listCartResponseModel?.data.items??[]) {
          print('Product: ${item.product}, Quantity: ${item.quantity}, Price: ${item.price}');
        }
        if (listCartResponseModel
        is ListCartResponseModel) {
          cartList.clear();
          cartList.addAll(listCartResponseModel?.data.items ?? []);
          globals.cartList?.clear();
          globals.cartList=listCartResponseModel?.data.items;

          isLoadingProductList.value = false;
        }

        isLoadingCart.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }
  }
  bool isProductInCart(String productId) {
    if ( globals.cartList == null ||  globals.cartList!.isEmpty) {
      print('cart is null !!!!!!!!!!!! ');
      return false;
    }

    print('cart has items ............ ');
    print(globals.cartList);
    return globals.cartList!.any((cartItem) => cartItem.productId == productId);
  }
}