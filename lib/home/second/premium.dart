import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:story_image_ai/model/send.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  @override
  void initState() {
    super.initState();
    listenToPurchases(); // Start listening to the purchase stream
  }
  bool isstarted=false;

  Widget f(double w,String str,String str1,String str2){
    return Padding(
      padding: const EdgeInsets.only(left: 18.0,right: 18),
      child: Container(
        width: w-40,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: w/3,
              height: 40,
              child: Center(child: Text(str,textAlign: TextAlign.left,)),
            ),
            Container(
              width: w/3-20,height: 40,
              color: Colors.grey.shade200,
              child: Center(child: Text(str1)),
            ),
            Container(
              width: w/3-20,height: 40,
              color: Colors.blue.shade50,
              child: Center(child: Text(str2)),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text("Subscription",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 18),
            child: Container(
              width: w-40,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w/3,
                    height: 40,
                    child: Center(child: Text("FEATURES",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700),)),
                  ),
                  Container(
                    width: w/3-20,height: 40,
                    color: Colors.grey.shade200,
                    child: Center(child: Text("FREE",style: TextStyle(fontWeight: FontWeight.w700),)),
                  ),
                  Container(
                    width: w/3-20,height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10)
                      )
                    ),
                    child: Center(child: Text("PREMIUM",style: TextStyle(fontWeight: FontWeight.w700),)),
                  ),
                ],
              ),
            ),
          ),
          f(w, "Per Day Reading", "20", "Unlimited"),
          f(w, "Per Day AI", "2", "10"),
          f(w, "Ads", "Yes", "No"),
          f(w, "Novels", "No", "Yes"),
          f(w, "Manga", "No", "Yes"),
          f(w, "Premium Badge", "No", "Yes"),
          f(w, "Post to Public", "No", "Yes"),
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 18),
            child: Container(
              width: w-40,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w/3,
                    height: 40,
                    child: Center(child: Text("Support",textAlign: TextAlign.left,)),
                  ),
                  Container(
                    width: w/3-20,height: 40,
                    color: Colors.grey.shade200,
                    child: Center(child: Text("Limited")),
                  ),
                  Container(
                    width: w/3-20,height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10)
                        )
                    ),
                    child: Center(child: Text("24x7")),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 18),
            child: Divider(),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text("    Choose Any Payment Mode",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),),
              Spacer()
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                c("Monthly", 2.0, w),
                c("Yearly", 20.0, w),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
  final Set<String> _productIds = {
    'monthly','yearly'
  };
  bool b=true;
  Widget c(String pid,double ser,double w){
    return InkWell(
      onTap: () async {
        if(ser==2.0){
            final productDetails = await fetchProductDetails("monthly");
            if (productDetails == null) {
              Send.message(context, 'Product details not found', false);
              setState(() {
                isstarted = false;
              });
              return;
            }
            final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

            try {
              // Buy a non-consumable for subscriptions
              await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
            } catch (e) {
              Send.message(context, 'Purchase failed: $e', false);
              print('Purchase error: $e');
            } finally {
              setState(() {
                isstarted = false;
              });
            }
        }else{
          final productDetails = await fetchProductDetails("yearly");
          if (productDetails == null) {
            Send.message(context, 'Product details not found', false);
            setState(() {
              isstarted = false;
            });
            return;
          }
          final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

          try {
            // Buy a non-consumable for subscriptions
            await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          } catch (e) {
            Send.message(context, 'Purchase failed: $e', false);
            print('Purchase error: $e');
          } finally {
            setState(() {
              isstarted = false;
            });
          }
        }
      },
      child: Container(
        width: w/2-20,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            color:Colors.black,
            border: Border.all(
                color: Colors.black,
                width: 2.5
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$pid",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
            Text("\$ ${ser.toInt()}",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 28),),
          ],
        ),
      ),
    );
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

// Define your product IDs
  Future<ProductDetails?> fetchProductDetails(String productId) async {
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_productIds);

    if (response.notFoundIDs.isNotEmpty) {
      setState(() {
        isstarted = false;
      });
      Send.message(context, 'Product not found: ${response.notFoundIDs}', false);
      print('Product not found: ${response.notFoundIDs}');
      return null;
    }

    return response.productDetails.firstWhere(
          (product) => product.id == productId, // Return null if no matching product is found
    );
  }

  final String uidd=FirebaseAuth.instance.currentUser!.uid??"gjg";
  void listenToPurchases() {
    _inAppPurchase.purchaseStream.listen((purchaseDetailsList) async {
      for (var purchaseDetails in purchaseDetailsList) {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          setState(() {
            isstarted = false;
          });
          print('Purchase successful: ${purchaseDetails.productID}');
          Navigator.pop(context);
          Send.message(context, "Success ! Welcome Premium", true);
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          setState(() {
            isstarted = false;
          });
          Send.message(context, 'Purchase failed: ${purchaseDetails.error}', false);
          print('Purchase failed: ${purchaseDetails.error}');
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          setState(() {
            isstarted = false;
          });
          Send.message(context, 'Purchase restored: ${purchaseDetails.productID}', false);
          print('Purchase restored: ${purchaseDetails.productID}');
        }

        // Complete pending purchases
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

}
