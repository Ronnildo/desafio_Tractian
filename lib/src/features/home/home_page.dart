import 'package:flutter/material.dart';
import 'package:treeviewapp/src/features/asset/asset_page.dart';
import 'package:treeviewapp/src/features/home/widgets/container_companies.dart';
import 'package:treeviewapp/src/models/companies_model.dart';
import 'package:treeviewapp/src/repository/companie_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CompanieRepository _activesService = CompanieRepository();
  
  
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
        child: FutureBuilder(
          future: _activesService.getCompanies(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List list = snapshot.data; 
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Companies companies =
                      Companies.fromJson(snapshot.data[index]);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerCompanies(
                        text: companies.name!,
                        nextPage: () => nextPage(companies.id!),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  nextPage(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssetPage(
          companieId: id,
        ),
      ),
    );
  }
}
