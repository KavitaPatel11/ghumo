import 'package:get/get.dart';
import 'package:ghumo_24/controllers/update_property_controller.dart';
class GetxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePropertyController>(() => UpdatePropertyController());
    
  }
}