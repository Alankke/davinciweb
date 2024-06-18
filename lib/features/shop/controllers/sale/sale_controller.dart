import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/data/repositories/shop/sale_repository.dart';
import 'package:davinciweb/features/shop/models/sale_model.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:davinciweb/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class SaleController extends GetxController {
  static SaleController get instance => Get.find();

  final saleRepository = Get.put(SaleRepository());
  final Rx<SaleModel> sale = SaleModel.emptySale().obs;
  final RxList<SaleModel> sales = <SaleModel>[].obs;
  final RxString generatedCode = ''.obs; //Variable observada para el código generado
  final RxString searchCode = ''.obs;


  // Número de ventas por lote (Renderizado)
  final int salesPerPage = 12;
  DocumentSnapshot? lastSaleDocument;

  //Estado de la carga
  final isLoading = false.obs;
  final hasMoreSales = true.obs;

  @override
  void onInit() {
    fetchInitialSales();
    super.onInit();
  }

  //Método para crear venta a partir de los datos de pantalla Checkout y guardarla en firestore
  void createSale(String userId, List<Map<String, dynamic>> products, double totalAmount, String paymentMethod) async {
    try {
      //Llena un SaleModel con los datos ingresados
      String generatedCode = DaVinciHelpersFunctions.generateSaleCode(6);
      Map<String, dynamic> saleData = {
        'UserId': userId,
        'Payment Method': paymentMethod,
        'State': 'Pendiente',
        'Code': generatedCode,
        'Products': products,
        'Total Amount': totalAmount,
        'Timestamp': Timestamp.now(),
      };
      //Llama a la clase repository para registrar la venta en firestore
      await saleRepository.saveSaleRecord(saleData);
      this.generatedCode.value = generatedCode; //Actualiza el código generado (hasta este momento el código es vacío)
      DaVinciSnackBars.success('Su compra se ha registrado, este es su código para el retiro $generatedCode');
    } catch (e) {
      DaVinciSnackBars.error('Se ha producido un error, intente nuevamente más tarde');
    }
  }

  //Método para traer inicialmente 12 ventas
  Future<void> fetchInitialSales() async {
    try {
      isLoading.value = true;
      final result =
          await saleRepository.getSalesFromFirestore(limit: salesPerPage);
      sales.assignAll(result.sales);
      lastSaleDocument = result.lastDocument;
      hasMoreSales.value = result.sales.length == salesPerPage;
    } catch (error) {
      throw 'Hubo un error al traer los productos $error';
    } finally {
      isLoading.value = false;
    }
  }

  //Método para traer más ventas desde la base de datos teniendo en cuenta la última venta traída
  Future<void> fetchMoreSales() async {
    if (isLoading.value || !hasMoreSales.value) return;

    try {
      isLoading.value = true;
      final result = await saleRepository.getSalesFromFirestore(
          limit: salesPerPage, startAfter: lastSaleDocument);
      sales.addAll(result.sales);
      lastSaleDocument = result.lastDocument;
      hasMoreSales.value = result.sales.length == salesPerPage;
    } catch (error) {
      throw 'Hubo un error al intentar traer más productos $error';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setState(String newState, String saleId) async {
    try {
      isLoading(true);
      Map<String, dynamic> saleData = {
        'State': newState,
      };
      await saleRepository.updateSingleField(saleData, saleId);
      final saleIndex = sales.indexWhere((sale) => sale.id == saleId);
      if (saleIndex != -1) {
        sales[saleIndex].state = newState;
        sales.refresh();
      }
    } catch (e) {
      DaVinciSnackBars.error('Error en la actualización de el estado de la venta');
      throw 'Hubo un error al actualizar el estado de la compra $e';
    } finally {
      isLoading(false);
    }
  }

  void setSearchCode(String code){
    searchCode.value = code;
  }

  //Método para eliminar venta de firestore
  Future<void> deleteProduct(String saleId) async {
    try {
      await saleRepository.deleteSale(saleId);
      sales.removeWhere((sale) => sale.id == saleId);
      DaVinciSnackBars.success('Su venta se ha eliminado exitosamente');
    } catch (e) {
      throw 'Hubo un error al eliminar la venta $e';
    }
  }
}
