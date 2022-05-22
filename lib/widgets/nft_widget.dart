import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_value/models/models.export.dart';
import 'package:wallet_value/services/services.export.dart';

class NFTWidget extends StatelessWidget {
  final UserNFT nft;
  final Function() onIgnored;
  const NFTWidget({
    Key? key,
    required this.nft,
    required this.onIgnored,
  }) : super(key: key);

  String getSelectedPriceValue() {
    switch (nft.selectedPriceOption.id) {
      case '30-day-average':
        return nft.dayAverage30.toStringAsFixed(4);
      case '7-day-average':
        return nft.dayAverage7.toStringAsFixed(4);
      case '1-day-average':
        return nft.dayAverage1.toStringAsFixed(4);
      case 'floor':
        return nft.floorPrice.toStringAsFixed(4);
      default:
        return nft.dayAverage30.toStringAsFixed(4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Constants.primaryColor,
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(nft.imageURL),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          nft.title,
                          style: Constants.titleTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('${nft.selectedPriceOption.title}: ${getSelectedPriceValue()}', style: Constants.statsTextStyle),
                        Text('You Own: ${nft.ownedNFTCount.toString()}', style: Constants.statsTextStyle),
                        Text('Total Value: ${nft.totalValue.toStringAsFixed(4)}', style: Constants.statsTextStyle),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: -10,
              bottom: -10,
              child: CupertinoButton(
                onPressed: onIgnored,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: nft.ignored ? Colors.green : Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      nft.ignored ? 'Include' : 'Ignore',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
