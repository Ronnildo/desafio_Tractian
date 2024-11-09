import 'package:flutter/material.dart';
import 'package:treeviewapp/src/features/asset/asset_page.dart';
import 'package:treeviewapp/src/features/home/widgets/container_companies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/images/logo.png"),
          width: 100,
          height: 100,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF17192D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ContainerCompanies(
              text: "Jaguar Unit",
              nextPage: nextPage,
            ),
            ContainerCompanies(
              text: "Tobias Unit",
              nextPage: nextPage,
            ),
            ContainerCompanies(
              text: "Apex Unit",
              nextPage: nextPage,
            )
          ],
        ),
      ),
    );
  }

  nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AssetPage(),
      ),
    );
  }
}
