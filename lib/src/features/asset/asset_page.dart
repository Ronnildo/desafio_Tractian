import 'package:flutter/material.dart';
import 'package:treeviewapp/src/features/asset/widgets/list_actives.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  final TextEditingController _controller = TextEditingController();
  bool clickSensor = false;
  bool clickCritico = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Assets",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF17192D),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                prefixIconColor: const Color(0xFF8E98A3),
                hintText: "Buscar Ativo ou Local",
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8E98A3),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: setColorClickSensor,
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color:
                          clickSensor ? Colors.blue : const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF8E98A3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bolt,
                          color: clickSensor
                              ? Colors.white
                              : const Color(0xFF8E98A3),
                        ),
                        Text(
                          "Sensor de Energia",
                          style: TextStyle(
                            color: clickSensor ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: setColorClickCritico,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: clickCritico
                          ? Colors.blue
                          : const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF8E98A3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.info,
                          color: clickCritico
                              ? Colors.white
                              : const Color(0xFF8E98A3),
                        ),
                        Text(
                          "Crítico",
                          style: TextStyle(
                            color: clickCritico ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const ListActives(text: "PRODUCTION AREA - RAW MATERIAL"),
        ],
      ),
    );
  }

  setColorClickSensor() {
    if (clickSensor) {
      setState(() {
        clickSensor = false;
      });
    } else {
      setState(() {
        clickSensor = true;
      });
    }
  }

  setColorClickCritico() {
    if (clickCritico) {
      setState(() {
        clickCritico = false;
      });
    } else {
      setState(() {
        clickCritico = true;
      });
    }
  }
}
