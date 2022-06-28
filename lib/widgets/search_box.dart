import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_value/pages/result_page.dart';
import 'package:wallet_value/services/services.export.dart';
import 'package:wallet_value/widgets/widgets.export.dart';

class SearchBox extends StatefulWidget {
  final ScreenType type;
  const SearchBox({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Flex(
        direction: widget.type == ScreenType.MOBILE ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CustomTextField(
              screenType: widget.type,
              controller: controller,
            ),
          ),
          SizedBox(
            width: widget.type == ScreenType.MOBILE ? 0 : 10,
            height: widget.type == ScreenType.MOBILE ? 10 : 0,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
              height: 54,
              width: widget.type == ScreenType.MOBILE ? double.infinity : 54,
              decoration: BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: widget.type == ScreenType.MOBILE
                    ? Text(
                        'Calculate',
                        style: Constants.buttonText,
                      )
                    : Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
            ),
            onPressed: () async {
              String address = controller.text.trim();

              bool addressRes = await OpenseaAPI.validateAddress(address);

              if (!addressRes) {
                showSnackbar(
                  context: context,
                  msg: 'Invalid address',
                  color: Constants.errorColor,
                );
                Analytics.logEvent(name: 'invalid_address', paramaters: {
                  'address': address,
                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                });
                return;
              }

              if (!mounted) return;


              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    ethAddress: address,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
