// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_value/models/models.export.dart';
import 'package:wallet_value/services/services.export.dart';

class OpenseaAPI {
  static const String API_ENDPOINT = 'https://api.opensea.io/api/v1';

  static Map<String, String> headers = {
    'Accept': 'application/json',
  };

  static Future<List<UserNFT>?> retrieveCollectionsOfUser(String userAddress) async {
    String params = 'asset_owner=$userAddress&offset=0&limit=300';

    String url = '$API_ENDPOINT/collections?$params';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List collections = jsonDecode(response.body);

      List<UserNFT> userNFTs = [];

      for (var collectionData in collections) {
        // Map<String, dynamic> contractData = collectionData['primary_asset_contracts'][0];
        Map<String, dynamic> collectionStats = collectionData['stats'];

        //https://api.opensea.io/api/v1/collection/{collection_slug}

        String slug = collectionData['slug'];

        http.Response fDataResponse = await http.get(Uri.parse('https://api.opensea.io/api/v1/collection/$slug'));

        double? floorPrice;

        if (fDataResponse.statusCode == 200) {
          Map<String, dynamic> fData = jsonDecode(fDataResponse.body);

          floorPrice = fData['collection']['stats']['floor_price'];
        }

        var nf = UserNFT(
          title: collectionData['name'] ?? '',
          contractAddress: '',
          externalURL: collectionData['external_link'] ?? '',
          imageURL: collectionData['image_url'] ?? '',
          dayAverage1: (collectionStats['one_day_average_price'] / 1.0) ?? 0.0,
          dayAverage7: (collectionStats['seven_day_average_price'] / 1.0) ?? 0.0,
          dayAverage30: (collectionStats['thirty_day_average_price'] / 1.0) ?? 0.0,
          floorPrice: (floorPrice ?? 0.0) / 1.0,
          ownedNFTCount: collectionData['owned_asset_count'] ?? 0,
          selectedPriceOption: Constants.priceOptions[0],
        );

        userNFTs.add(nf);
      }

      return userNFTs;
    } else {
      return null;
    }
  }

  static Future<bool> validateAddress(String ethAddress) async {
    http.Response response = await http.post(
      Uri.parse('https://www.walletcollector.xyz/api/validateAddress?address=$ethAddress&network=ETH'),
      body: {
        'address': ethAddress,
      },
    );

    if (response.statusCode == 200) {
      bool result = jsonDecode(response.body)['result'];
      return result;
    } else {
      return false;
    }
  }
}
