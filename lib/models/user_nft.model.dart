import 'package:wallet_value/models/floor_option.model.dart';

class UserNFT {
  String title;
  String contractAddress;
  String externalURL;
  double dayAverage1;
  double dayAverage7;
  double dayAverage30;
  double floorPrice;
  int ownedNFTCount;
  bool ignored;
  String imageURL;
  double totalValue;
  FloorOption selectedPriceOption;

  UserNFT({
    required this.title,
    required this.contractAddress,
    required this.externalURL,
    required this.dayAverage1,
    required this.dayAverage7,
    required this.dayAverage30,
    required this.floorPrice,
    required this.ownedNFTCount,
    this.ignored = false,
    required this.imageURL,
    this.totalValue = 0,
    required this.selectedPriceOption,
  }) {
    update();
  }

  void update() {
    switch (selectedPriceOption.id) {
      case '30-day-average':
        totalValue = ownedNFTCount * dayAverage30;
        break;
      case '7-day-average':
        totalValue = ownedNFTCount * dayAverage7;
        break;
      case '1-day-average':
        totalValue = ownedNFTCount * dayAverage1;
        break;
      case 'floor':
        totalValue = ownedNFTCount * floorPrice;
        break;
    }
  }
}
