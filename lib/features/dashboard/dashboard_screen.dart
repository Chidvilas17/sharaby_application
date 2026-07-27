import 'package:flutter/material.dart';
import 'package:sharaby_center_clinic/theme/app_colors.dart';
import 'package:sharaby_center_clinic/widgets/app_drawer.dart';
import 'package:sharaby_center_clinic/widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              //================ HEADER =================
              Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
                decoration: const BoxDecoration(
                  gradient: AppColors.headerGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [

                    Row(
                      children: [

                        Builder(
                          builder: (context) => IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const Spacer(),

                        const Text(
                          "Sharaby Center",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        Stack(
                          children: [
                            const Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 30,
                            ),
                            Positioned(
                              right: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Good Morning 👋",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome Back Doctor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search patients...",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //================ HERO BANNER =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff5DA9FF),
                        Color(0xff84C6FF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            const Text(
                              "Healthcare",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              "Management System",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),

                            const SizedBox(height: 15),

                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("View Patients"),
                            )
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.local_hospital,
                        size: 90,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              //================ STATISTICS =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    DashboardCard(
                      icon: Icons.people,
                      title: "Patients",
                      value: "254",
                      onTap: () {},
                    ),

                    DashboardCard(
                      icon: Icons.calendar_month,
                      title: "Appointments",
                      value: "18",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    DashboardCard(
                      icon: Icons.medication,
                      title: "Prescriptions",
                      value: "72",
                      onTap: () {},
                    ),

                    DashboardCard(
                      icon: Icons.receipt_long,
                      title: "Billing",
                      value: "\$18K",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //================ QUICK ACTIONS =================

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    _quick(Icons.people, "Patients"),

                    _quick(Icons.medication, "Prescription"),

                    _quick(Icons.receipt, "Billing"),

                    _quick(Icons.bar_chart, "Reports"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //================ APPOINTMENTS =================

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today's Appointments",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              _appointment(
                "Ahmed Ali",
                "09:30 AM",
                "Diabetes Follow-up",
              ),

              _appointment(
                "Sara Mohamed",
                "11:00 AM",
                "Blood Pressure Check",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _quick(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }

  static Widget _appointment(
      String patient,
      String time,
      String diagnosis,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 6,
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(patient),
          subtitle: Text(diagnosis),
          trailing: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}