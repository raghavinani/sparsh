import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'dart:async';
import 'dart:ui';

import 'token_detail.dart';

class TokenScanPage extends StatefulWidget {
  const TokenScanPage({super.key});

  @override
  State<TokenScanPage> createState() => _TokenScanPageState();
}

class _TokenScanPageState extends State<TokenScanPage> {
  MobileScannerController controller = MobileScannerController();
  bool isScanned = false;
  String scannedToken = '';
  bool flashOn = false;

  Timer? scanTimeoutTimer;
  bool scanFailed = false;

  // Pin logic
  final List<TextEditingController> pinControllers =
      List.generate(4, (_) => TextEditingController());

  void handleScan(String token) {
    scanTimeoutTimer?.cancel(); // Stop timeout timer
    controller.stop();
    setState(() {
      scannedToken = token;
      isScanned = true;
      scanFailed = false;
    });
  }

  void startScanTimeout() {
    scanTimeoutTimer?.cancel(); // Reset if exists
    scanTimeoutTimer = Timer(const Duration(seconds: 30), () {
      if (!isScanned) {
        controller.stop();
        setState(() {
          scanFailed = true;
        });
      }
    });
  }

  void resetScan() {
    setState(() {
      scannedToken = '';
      isScanned = false;
      scanFailed = false;
      for (var ctrl in pinControllers) {
        ctrl.clear();
      }
    });
    controller.start();
    startScanTimeout();
  }

  void navigateToDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TokenDetailsPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    startScanTimeout(); // Start scan timeout when screen opens
  }

  @override
  void dispose() {
    controller.dispose();
    scanTimeoutTimer?.cancel();
    for (var ctrl in pinControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      // drawer: CustomSidebar(),
      // endDrawer: const ProfileSidebar(),
      
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) {
              if (!isScanned && !scanFailed) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final code = barcodes.first.rawValue ?? "---";
                  handleScan(code);
                }
              }
            },
          ),
          if (!isScanned && !scanFailed) ...[
            // Instruction
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Place the QR Code properly inside the area\nScanning will start automatically",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            // Blue Scanner Frame
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            // Flash Icon
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Center(
                child: Material(
                  shape: const CircleBorder(),
                  elevation: 6,
                  color: Colors.white,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      controller.toggleTorch();
                      setState(() {
                        flashOn = !flashOn;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child:
                          Icon(Icons.flash_on, size: 32, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],

          // ✅ Popup on scan
          if (isScanned)
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Scan done Successfully",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text("Token No.", style: TextStyle(fontSize: 18)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        scannedToken,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Enter Pin Code :",
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: TextField(
                            controller: pinControllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: const InputDecoration(counterText: ''),
                            onChanged: (value) {
                              if (value.length == 1 &&
                                  index < pinControllers.length - 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: navigateToDetails,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text("View Details",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          if (scanFailed)
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "OOPS! Scan didn't work",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text("Token No.", style: TextStyle(fontSize: 18)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        scannedToken.isEmpty ? "---" : scannedToken,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Icon(Icons.error_outline_rounded,
                        color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: resetScan,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Try Again",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      
    );
  }
}