import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}


class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 60,
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
                border: Border.all(
                  color: Colors.grey
                ),
                borderRadius: 
                BorderRadius.circular(100)
              ),
              child: Icon(Icons.arrow_back_ios_rounded,
                  size: 20, color: Colors.black),
            ),
            )
          ),
        ),
        title: const Text(
          "Хэрэглэгчийн булан",
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            Row(
              children: [
                Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 255, 72),
                borderRadius: BorderRadius.circular(50)
              ),
            ),
            SizedBox(width: 4),
            Text(
              "Захиалга (1)",
              style: TextStyle(
                color: Colors.grey
              ),
            )
              ],
            ),
            SizedBox(height: 12),
            Container( 
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              width: 370,
              height: 210,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 113, 219),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text(
                          "2 хоногийн дараа",
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                      ),
                      Text(
                        "Захиалга цуцлах",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.all(10),
                     height: 160,
                     width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Text(
                              "Fresh Car Wash",
                              style: TextStyle(
                                fontWeight: FontWeight.w600
                              ),
                            
                            ),
                            Text(
                              "20,000₮",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                              ),
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: 140,
                                  height: 39,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 0, 113, 219),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                      ),
                                      Text(
                                    "Ням,2-р сар 5",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                    ],
                                  )
                                ),
                                    Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: 140,
                                  height: 39,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 0, 113, 219),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timelapse_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                    "10:00",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                    ],
                                  )
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Container(
                                child: Row(
                                  children: [
                                      Icon(
                                  Icons.location_on
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "ХУД 1-хороо",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                      Icon(
                                  Icons.time_to_leave 
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Suv",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                                  ],
                                ),
                              ),
                              ],
                            )
                      ],
                    ),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}