import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CarModel {
  final String brand;
  final String model;
  final String plate;
  final int carImageIndex;

  CarModel({
    required this.brand,
    required this.model,
    required this.plate,
    required this.carImageIndex,
  });
}

class Addcar extends StatefulWidget {
  const Addcar({super.key});

  @override
  State<Addcar> createState() => _AddcarState();
}

class _AddcarState extends State<Addcar> {
  List<CarModel> cars = [];

  final List<String> carImages = [
    'assets/images/car_front.png',
    'assets/images/car_side.png',
    'assets/images/car_back.png',
  ];

  void _showAddCarModal() {
    final brandController = TextEditingController();
    final modelController = TextEditingController();
    final plateController = TextEditingController();
    int selectedCar = -1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Машин Нэмэх",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(Icons.close, size: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Brand
                    const Text("Брэнд",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: brandController,
                      decoration: InputDecoration(
                        hintText: "Бичнэ үү",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Model
                    const Text("Загвар",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: modelController,
                      decoration: InputDecoration(
                        hintText: "Бичнэ үү",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Plate Number
                    const Text("Машины дугаар",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: plateController,
                      decoration: InputDecoration(
                        hintText: "Бичнэ үү",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Car Image Selection
                    const Text("Машины зураг",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(3, (index) {
                        return GestureDetector(
                          onTap: () {
                            setModalState(() => selectedCar = index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedCar == index
                                    ? const Color(0xFF0071DB)
                                    : Colors.grey.shade300,
                                width: selectedCar == index ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                carImages[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.directions_car,
                                        size: 40,
                                        color: Colors.grey.shade400),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    // Modal Add Button
                    GestureDetector(
                      onTap: () {
                        if (brandController.text.isNotEmpty &&
                            modelController.text.isNotEmpty &&
                            plateController.text.isNotEmpty) {
                          setState(() {
                            cars.add(CarModel(
                              brand: brandController.text,
                              model: modelController.text,
                              plate: plateController.text,
                              carImageIndex:
                                  selectedCar == -1 ? 0 : selectedCar,
                            ));
                          });
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Бүх талбарыг бөглөнө үү"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0071DB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Нэмэх",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    size: 20, color: Colors.black),
              ),
            ),
          ),
        ),
        title: const Text(
          "Миний машин",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dotted border empty state
            if (cars.isEmpty)
              DottedBorder(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey.shade50,
                    child: Center(
                      child: Text(
                        'Бүртэгдсэн машин одоогоор алга.',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                ),
              ),

            // Car list
            if (cars.isNotEmpty)
              ...cars.asMap().entries.map((entry) {
                final index = entry.key;
                final car = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Car image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F1FB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            carImages[car.carImageIndex],
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.directions_car,
                              size: 36,
                              color: Color(0xFF0071DB),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Car info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F1FB),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Брэнд: ${car.brand}",
                                style: const TextStyle(
                                  color: Color(0xFF0071DB),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F1FB),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Загвар: ${car.model}",
                                style: const TextStyle(
                                  color: Color(0xFF0071DB),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F1FB),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Машины дугаар: ${car.plate}",
                                style: const TextStyle(
                                  color: Color(0xFF0071DB),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Delete button
                      GestureDetector(
                        onTap: () {
                          setState(() => cars.removeAt(index));
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.delete_outline,
                              color: Colors.red.shade400, size: 20),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

            const SizedBox(height: 16),

            // Add button — always right below content
            GestureDetector(
              onTap: _showAddCarModal,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF0071DB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Нэмэх",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.add_circle_outline, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}