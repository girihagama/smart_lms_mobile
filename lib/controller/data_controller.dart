import 'package:smart_lms/database/db_helper.dart';

class DataController {

void addItemToInventory() async {
  Map<String, dynamic> newItem = {
    'name': 'Item 1',
    'description': 'This is item 1 description',
    'quantity': 10,
    'price': 100.0,
  };

  await DatabaseHelper.insertItem(newItem);
}






}