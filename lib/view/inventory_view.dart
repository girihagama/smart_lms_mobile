import 'package:smart_lms/controller/data_controller.dart';
import 'package:smart_lms/database/db_helper.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Map<String, dynamic>> inventory = [];

  @override
  void initState() {
    super.initState();
    // DataController().addItemToInventory();
    fetchInventory();
  }

  // Fetch inventory data
  void fetchInventory() async {
    List<Map<String, dynamic>> items = await DatabaseHelper.getItems();
    setState(() {
      inventory = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory')),
      body: ListView.builder(
        itemCount: inventory.length,
        itemBuilder: (context, index) {
          var item = inventory[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('${item['description']} - Quantity: ${item['quantity']} - \$${item['price']}'),
          );
        },
      ),
    );
  }
}
