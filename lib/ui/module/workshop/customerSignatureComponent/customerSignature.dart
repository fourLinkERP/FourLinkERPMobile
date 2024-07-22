import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../../../theme/theme_helper.dart';

class CustomerSignatureComponent extends StatefulWidget {
  @override
  _CustomerSignatureComponentState createState() => _CustomerSignatureComponentState();
}

class _CustomerSignatureComponentState extends State<CustomerSignatureComponent> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          children: [
            Signature(
              controller: _controller,
              height: 250,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: () {
                      _controller.clear();
                    },
                    child: const Text('Clear'),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: () async {
                      if (_controller.isNotEmpty) {
                        final signature = await _controller.toPngBytes();
                        Navigator.of(context).pop(signature);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}