import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import './camera_page.dart';

import '../common/utils/colors.dart';
import '../common/utils/theme.dart';
import '../common/widgets/input_field.dart';

import '../controllers/item_controller.dart';

import '../models/item.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DateTime _selectedPurchasedDate = DateTime.now();
  DateTime _selectedExpiryDate = DateTime.now().add(const Duration(days: 1));

  final TextEditingController _nameController = TextEditingController();

  int _quantity = 1;
  final int _quantityMin = 1;
  final int _quantityMax = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.825,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildCameraAndNameRow(),
            const SizedBox(height: 20),
            _buildQuantityRow(),
            _buildDateField("Purchase Date", _selectedPurchasedDate, true),
            _buildDateField("Expiry Date", _selectedExpiryDate, false),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom == 0
                  ? MediaQuery.of(context).size.height * 0.15
                  : 16,
            ),
            Center(
              child: ElevatedButton(
                onPressed: _validateItem,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 0, 175, 84),
                  ),
                ),
                child: SizedBox(
                  height: 60,
                  width: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.check,
                          size: 30,
                          color: whiteClr,
                        ),
                      ),
                      Text(
                        "Add this item",
                        style: titleStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "All Items",
          style: headingStyle,
        ),
        const Spacer(),
        IconButton(
          onPressed: () async {
            // await Get.to(() => const Scanner());
            print("Open Scanner");
          },
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: primaryClrMaterial,
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCameraAndNameRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => const CameraPage());
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              color: Colors.grey[600],
              size: 50,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: MyInputField(
            placeholder: "Item Name",
            controller: _nameController,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildQuantityRow() {
    return Row(
      children: [
        Text(
          "Quantity",
          style: titleStyle,
        ),
        const Spacer(),
        _buildQuantityButton(Icons.remove, _quantity > _quantityMin, () {
          _updateQuantity(-1, isButtonPressed: true);
        }),
        NumberPicker(
          itemWidth: 45,
          axis: Axis.horizontal,
          minValue: _quantityMin,
          maxValue: _quantityMax,
          haptics: true,
          value: _quantity,
          onChanged: _updateQuantity,
        ),
        _buildQuantityButton(Icons.add, _quantity < _quantityMax, () {
          _updateQuantity(1, isButtonPressed: true);
        }),
      ],
    );
  }

  Widget _buildQuantityButton(
      IconData icon, bool enabled, VoidCallback onPressed) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.grey : Colors.grey[300],
          size: 30,
        ),
      ),
    );
  }

  Widget _buildDateField(
      String title, DateTime selectedDate, bool isPurchaseDate) {
    return MyInputField(
      title: title,
      placeholder: DateFormat("dd / MM / yyyy").format(selectedDate),
      widget: IconButton(
        icon: const Icon(
          Icons.calendar_month_outlined,
          color: greyClr,
        ),
        onPressed: () {
          _getDateFromUser(isPurchaseDate: isPurchaseDate);
        },
      ),
    );
  }

  void _updateQuantity(int change, {bool isButtonPressed = false}) {
    if (isButtonPressed) {
      final newQuantity = _quantity + change;
      setState(() {
        _quantity = newQuantity.clamp(_quantityMin, _quantityMax);
      });
    } else {
      setState(() {
        _quantity = change.clamp(_quantityMin, _quantityMax);
      });
    }
  }

  void _getDateFromUser({required bool isPurchaseDate}) async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate:
          isPurchaseDate ? _selectedPurchasedDate : _selectedExpiryDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickerDate != null) {
      setState(() {
        if (isPurchaseDate) {
          _selectedPurchasedDate = pickerDate;
        } else {
          _selectedExpiryDate = pickerDate;
        }
      });
    }
  }

  void _validateItem() {
    if (_nameController.text.isNotEmpty) {
      _setNotifications();
      _addItemToDb();
      // _setNotificationSchedule();
      // Get.back();
    } else {
      _showSnackbar("Required", "Item name is a required field");
    }
  }

  void _setNotifications() {
    print("Set all notification times here");
    // we will set notification for 7 days and 1 day before expiry date if expiry date is more than 7 days from now
    // if expiry date is less than 7 days from now then we will set notification for 1 day before expiry date and on expiry date whose dates expiryDate-1 and expiryDate-7 will be stored in notifyOneDayBefore and notifySevenDaysBefore respectively as follows:
    DateTime _notifyOneDayBefore, _notifySevenDaysBefore, _notifyOnExpiryDay;

    _notifyOneDayBefore = _selectedExpiryDate.subtract(Duration(days: 1));
    _notifySevenDaysBefore = _selectedExpiryDate.subtract(Duration(days: 7));
    _notifyOnExpiryDay = _selectedExpiryDate;

    print("Expiry Date: $_selectedExpiryDate");
    print("Notify 1 day before: $_notifyOneDayBefore");
    print("Notify 7 days before: $_notifySevenDaysBefore");
    print("Notify on expiry day: $_notifyOnExpiryDay");
  }

  void _addItemToDb() async {
    ItemController itemController = Get.find();
    try {
      await itemController.addItem(
        item: Item(
          productName: _nameController.text,
          quantity: _quantity,
          // image: image,
          purchaseDate: DateFormat("dd/MM/yyyy").format(_selectedPurchasedDate),
          expiryDate: DateFormat("dd/MM/yyyy").format(_selectedExpiryDate),
          // productBarcode: _productBarcode,
        ),
      );
    } catch (e) {
      debugPrint("Error in _addItemToDb: ${e.toString()}");
    }
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? whiteClr : blackClr,
      colorText: Get.isDarkMode ? blackClr : whiteClr,
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.red,
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  // _setNotificationSchedule() {
  //   DateTime dateWith24HrTimeFormat =
  //       DateFormat("HH:mm a").parse(_notifyTime.toString());

  //   var myTime = DateFormat("HH:mm").format(dateWith24HrTimeFormat);

  //   if (_selectedRemind == 0) {
  //     // if "NO REMINDER" is selected then schedule notification at "12:00 am" ONLY on the "selected date"
  //     notifyHelper.scheduledNotification(
  //       Item(
  //         id: _itemController.itemList.length,
  //         name: _nameController.text,
  //         descp: _descpController.text,
  //         date: DateFormat("dd/MM/yyyy").format(_selectedDate),
  //         notifyTime: _notifyTime,
  //         remind: _selectedRemind,
  //         repeat: _selectedRepeat,
  //         color: _selectedColor,
  //         isCompleted: 0,
  //       ),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(_selectedDate).substring(6, 10)),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(_selectedDate).substring(3, 5)),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(_selectedDate).substring(0, 2)),
  //       int.parse(myTime.toString().split(":")[0]),
  //       int.parse(myTime.toString().split(":")[1]),
  //     );
  //   } else {
  //     // if "REMINDER" is selected then schedule notification at "12:00 am" "REMINDER" days before the "selected date" and also schedule notification at "12:00 am" on the "selected date"

  //     // calculating reminder date
  //     DateTime reminderDate = _selectedDate.subtract(
  //       Duration(days: _selectedRemind),
  //     );

  //     // schedule notification at "12:00 am", "REMINDER" days before the "selected date"
  //     notifyHelper.scheduledNotification(
  //       Item(
  //         id: Random().nextInt(1000000),
  //         name: _nameController.text,
  //         descp: _descpController.text,
  //         date: DateFormat("dd/MM/yyyy").format(_selectedDate),
  //         notifyTime: _notifyTime,
  //         remind: _selectedRemind,
  //         repeat: _selectedRepeat,
  //         color: _selectedColor,
  //         isCompleted: 0,
  //       ),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(reminderDate).substring(6, 10)),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(reminderDate).substring(3, 5)),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(reminderDate).substring(0, 2)),
  //       int.parse(myTime.toString().split(":")[0]),
  //       int.parse(myTime.toString().split(":")[1]),
  //     );

  //     // schedule notification at "12:00 am" on the "selected date"
  //     notifyHelper.scheduledNotification(
  //       Item(
  //         id: Random().nextInt(1000000),
  //         name: _nameController.text,
  //         descp: _descpController.text,
  //         date: DateFormat("dd/MM/yyyy").format(_selectedDate),
  //         notifyTime: _notifyTime,
  //         remind: _selectedRemind,
  //         repeat: _selectedRepeat,
  //         color: _selectedColor,
  //         isCompleted: 0,
  //       ),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(_selectedDate).substring(6, 10)),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(_selectedDate).substring(3, 5)),
  //       int.parse(
  //           DateFormat('dd/MM/yyyy').format(_selectedDate).substring(0, 2)),
  //       int.parse(myTime.toString().split(":")[0]),
  //       int.parse(myTime.toString().split(":")[1]),
  //     );
  //   }
  // }
}
