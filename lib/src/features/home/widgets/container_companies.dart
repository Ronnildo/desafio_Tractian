import 'package:flutter/material.dart';

class ContainerCompanies extends StatefulWidget {
  final String text;
  final void Function() nextPage;
  const ContainerCompanies({
    super.key,
    required this.text,
    required this.nextPage,
  });

  @override
  State<ContainerCompanies> createState() => _ContainerCompaniesState();
}

class _ContainerCompaniesState extends State<ContainerCompanies> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.nextPage,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.only(left: 32),
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.blue,
      
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage("assets/images/image.png"),
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
