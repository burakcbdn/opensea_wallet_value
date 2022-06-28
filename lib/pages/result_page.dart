import 'package:flutter/material.dart';
import 'package:wallet_value/models/models.export.dart';
import 'package:wallet_value/services/services.export.dart';
import 'package:wallet_value/widgets/widgets.export.dart';

class ResultPage extends StatefulWidget {
  final String ethAddress;
  const ResultPage({
    Key? key,
    required this.ethAddress,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    retrieveCollections();
  }

  bool loading = true;

  double totalValue = 0;

  void calculateTotalValue() {
    totalValue = 0;
    if (userNFTs == null) {
      return;
    }

    for (UserNFT element in userNFTs!.where((element) => element.ignored != true).toList()) {
      totalValue += element.totalValue;
    }
  }

  List<UserNFT>? userNFTs;

  Future retrieveCollections() async {
    List<UserNFT>? userNFTsTmp = await OpenseaAPI.retrieveCollectionsOfUser(widget.ethAddress);
    if (userNFTsTmp == null) {
      setState(() {
        userNFTs = [];
        loading = false;
      });
      showSnackbar(
        context: context,
        msg: 'Something went wrong!',
        color: Constants.errorColor,
      );
      return;
    }

    setState(() {
      userNFTs = userNFTsTmp;
      calculateTotalValue();
      loading = false;
    });

    Analytics.logEvent(name: 'value_check', paramaters: {
      'address': widget.ethAddress,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'total_value': totalValue,
      'nft_count': userNFTs!.length,
      'collections': userNFTs!.map((e) => e.title.toString()).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Title(
      color: Constants.primaryColor,
      title: 'OpenSea Wallet Value',
      child: Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          ScreenType type = Utils.getScreenType(constraints);
          bool isMobile = type == ScreenType.MOBILE;
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flex(
                    direction: isMobile || type == ScreenType.TABLET ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: isMobile || type == ScreenType.TABLET ? MainAxisSize.min : MainAxisSize.max,
                    children: [
                      Flexible(
                        child: SearchBox(
                          type: type,
                        ),
                      ),
                      SizedBox(
                        width: isMobile || type == ScreenType.TABLET ? 0 : 15,
                        height: isMobile || type == ScreenType.TABLET ? 15 : 0,
                      ),
                      Container(
                        height: 53,
                        width: isMobile ? double.infinity : 250,
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            '${totalValue.toStringAsFixed(4)} ETH',
                            style: Constants.buttonText,
                          ),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: Constants.priceOptions
                          .map<Widget>(
                            (f) => FloorOptionWidget(
                              floorOption: f,
                              onPressed: () {
                                setState(() {
                                  for (FloorOption element in Constants.priceOptions) {
                                    element.selected = false;
                                  }
                                  f.selected = true;
                                  for (var element in userNFTs!) {
                                    element.selectedPriceOption = f;
                                    element.update();
                                  }
                                  calculateTotalValue();
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  if (userNFTs != null)
                    Expanded(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 650,
                          crossAxisSpacing: 10,
                          childAspectRatio: isMobile ? 2.7 : 3,
                        ),
                        children: userNFTs!.map<Widget>((nft) {
                          return NFTWidget(
                            nft: nft,
                            onIgnored: () {
                              nft.ignored = !nft.ignored;
                              setState(() {
                                calculateTotalValue();
                              });

                              if (nft.ignored) {
                                Analytics.logEvent(name: 'ignore', paramaters: {
                                  'address': widget.ethAddress,
                                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                                  'collection': nft.title,
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  if (loading) CustomLoading()
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
