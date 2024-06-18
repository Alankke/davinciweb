import 'package:davinciweb/common/widgets/appbar/admin_appbar.dart';
import 'package:davinciweb/data/repositories/user/user_repository.dart';
import 'package:davinciweb/features/authentication/models/user_model.dart';
import 'package:davinciweb/features/shop/controllers/sale/sale_controller.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageSales extends StatelessWidget {
  const ManageSales({super.key});

  @override
  Widget build(BuildContext context) {
    final saleController = Get.put(SaleController());
    final userRepository = Get.put(UserRepository());

    return Scaffold(
      appBar: const AdminAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Buscador
            TextField(
              onChanged: (value) {
                saleController.setSearchCode(value);
              },
              decoration: InputDecoration(
                labelText: 'Buscar por código',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Iniciar búsqueda
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Obx(() {
              if (saleController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (saleController.sales.isEmpty) {
                return const AlertDialog(
                  title: Text('Advertencia', style: TextStyle(fontSize: 18)),
                  content: Text('No hay ventas registradas'),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Código')),
                        DataColumn(label: Text('Cliente')),
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Fecha')),
                        DataColumn(label: Text('Método de pago')),
                        DataColumn(label: Text('Total')),
                      ],
                      rows: saleController.sales.map((sale) {
                        final date = sale.timestamp.toDate();
                        final isHighlighted = saleController.searchCode.value
                            .toLowerCase()
                            .contains(sale.generatedCode.toLowerCase());
                        return DataRow(
                          color: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              return isHighlighted ? Color.fromARGB(255, 224, 158, 57) : null;
                            },
                          ),
                          cells: [
                            DataCell(Text(sale.generatedCode)),
                            DataCell(FutureBuilder<UserModel>(
                              future: userRepository.getUserById(sale.userId),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                final user = snapshot.data!;
                                return TextButton(
                                  child: Text(user.name),
                                  onPressed: () => showUserInfoDialog(context, user),
                                );
                              },
                            )),
                            DataCell(
                              DropdownButton<String>(
                                value: sale.state, // Estado inicial del dropdown
                                items: const [
                                  DropdownMenuItem(value: 'Pendiente', child: Text('Pendiente')),
                                  DropdownMenuItem(value: 'Cancelado', child: Text('Cancelado')),
                                  DropdownMenuItem(value: 'Abonado', child: Text('Abonado')),
                                  DropdownMenuItem(value: 'Retirado', child: Text('Retirado')),
                                ],
                                onChanged: (selectedState) {
                                  if (selectedState != null) {
                                    saleController.setState(selectedState, sale.id);
                                  }
                                },
                              ),
                            ),
                            DataCell(Text('${date.day}/${date.month}/${date.year}')),
                            DataCell(Text(sale.paymentMethod)),
                            DataCell(Text(DaVinciFormatter.formatCurrency(sale.totalAmount))),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              }
            }),
            Obx(() {
              return saleController.hasMoreSales.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => saleController.fetchMoreSales(),
                          child: saleController.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text('Cargar más'),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  void showUserInfoDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user.name, style: DaVinciTextStyles.dialogTitle,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nombre completo: ${user.name}'),
              Text('Nombre de usuario: ${user.username}'),              
              Text('Email: ${user.email}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
