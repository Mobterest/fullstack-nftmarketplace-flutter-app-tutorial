import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft_marketplace/utils/config.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class NftProvider extends ChangeNotifier {
  Web3Client? _web3client;
  ContractAbi? _abiCode;
  EthereumAddress? _contractAddress;
  DeployedContract? _deployedContract;
  final EthPrivateKey _creds = EthPrivateKey.fromHex(dummyPrivateKey);
  ContractFunction? _addProfile;
  ContractFunction? _profileCount;
  ContractFunction? _getProfile;
  ContractFunction? _getMyNfts;
  ContractFunction? _getCollectables;
  ContractFunction? _createNft;
  ContractFunction? _sellSubscription;
  ContractFunction? _getSubscriptions;
  ContractFunction? _buySubscription;
  ContractFunction? _renewSubscription;
  ContractFunction? _expiresAt;
  ContractFunction? _cancelSubscription;
  ContractFunction? _likeSubscription;
  ContractFunction? _unlikeSubsription;
  ContractFunction? _profiles;
  double _balance = 0.00;
  int profileCount = 0;
  List<dynamic> _myProfile = [];
  List<dynamic> _userProfile = [];
  List<dynamic> _myNfts = [];
  List<dynamic> _collectables = [];
  List<dynamic> _nfts = [];
  int _duration = 0;

  double get balance => _balance;
  List<dynamic> get myProfile => _myProfile;
  List<dynamic> get userProfile => _userProfile;
  List<dynamic> get myNfts => _myNfts;
  List<dynamic> get collectables => _collectables;
  List<dynamic> get nfts => _nfts;

  NftProvider();

  Future<void> init() async {
    _web3client = Web3Client(url, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    await getABI();
    await getDeployedContract();
  }

  Future<void> getABI() async {
    final String abiFile = await rootBundle.loadString('assets/json/abi.json');
    final jsonABI = await json.decode(abiFile);
    _abiCode = ContractAbi.fromJson(
        json.encode(jsonABI['abi']), json.encode(jsonABI['contractName']));
    _contractAddress = EthereumAddress.fromHex(contractAddress);
  }

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode!, _contractAddress!);
    _addProfile = _deployedContract!.function('addProfile');
    _profileCount = _deployedContract!.function('getNumberOfUsers');
    _getProfile = _deployedContract!.function('profiles');
    _getMyNfts = _deployedContract!.function('getNfts');
    _getCollectables = _deployedContract!.function('getCollectables');
    _createNft = _deployedContract!.function('createNft');
    _sellSubscription = _deployedContract!.function('sellSubscription');
    _getSubscriptions = _deployedContract!.function('getSubscriptions');
    _buySubscription = _deployedContract!.function('buySubscription');
    _renewSubscription = _deployedContract!.function('renewSubscription');
    _expiresAt = _deployedContract!.function('expiresAt');
    _cancelSubscription = _deployedContract!.function('cancelSubscription');
    _likeSubscription = _deployedContract!.function('likeSubscription');
    _unlikeSubsription = _deployedContract!.function('unlikeSubscription');
    _profiles = _deployedContract!.function('profiles');
  }

  Future<void> addProfile() async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            nonce: await _web3client!
                .getTransactionCount(EthereumAddress.fromHex(dummyAddress)),
            from: EthereumAddress.fromHex(dummyAddress),
            contract: _deployedContract!,
            function: _addProfile!,
            parameters: []),
        chainId: 1337);
    EtherAmount balance =
        await _web3client!.getBalance(EthereumAddress.fromHex(dummyAddress));
    _balance = balance.getValueInUnit(EtherUnit.ether);
    notifyListeners();
  }

  Future<void> getMyProfile() async {
    await init();
    List profileList = await _web3client!.call(
        contract: _deployedContract!, function: _profileCount!, params: []);
    BigInt totalProfiles = profileList[0];
    profileCount = totalProfiles.toInt();
    List allProfiles = [];
    for (int i = 1; i < profileCount; i++) {
      List temp = await _web3client!.call(
          contract: _deployedContract!,
          function: _getProfile!,
          params: [BigInt.from(i)]);
      allProfiles.add(temp);
    }
    for (int i = 0; i < allProfiles.length; i++) {
      if (allProfiles[i][0] == EthereumAddress.fromHex(dummyAddress)) {
        _myProfile = allProfiles[i];
      }
    }
    notifyListeners();
  }

  Future<void> getMyNfts(String address) async {
    await init();
    List nftList = await _web3client!.call(
        sender: EthereumAddress.fromHex(address),
        contract: _deployedContract!,
        function: _getMyNfts!,
        params: []);
    nftList[0].removeAt(0);
    _myNfts = nftList[0];
    _myNfts.removeWhere(
        (item) => item[1] == EthereumAddress.fromHex(genesisAddress));

    notifyListeners();
  }

  Future<void> getCollectables(String address) async {
    await init();
    List collectableList = await _web3client!.call(
        sender: EthereumAddress.fromHex(address),
        contract: _deployedContract!,
        function: _getCollectables!,
        params: []);

    _collectables = collectableList[0];
    _collectables.removeWhere(
        (item) => item[1] == EthereumAddress.fromHex(genesisAddress));
    notifyListeners();
  }

  Future<void> createNft(
      String tokenUri, String title, String description) async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            nonce: await _web3client!
                .getTransactionCount(EthereumAddress.fromHex(dummyAddress)),
            from: EthereumAddress.fromHex(dummyAddress),
            contract: _deployedContract!,
            function: _createNft!,
            parameters: [tokenUri, title, description]),
        chainId: 1337);
    getMyNfts(dummyAddress);
  }

  Future<void> sellSubscription(int tokenId, int price, int duration) async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            value: EtherAmount.fromInt(EtherUnit.ether, price),
            from: EthereumAddress.fromHex(dummyAddress),
            contract: _deployedContract!,
            function: _sellSubscription!,
            parameters: [BigInt.from(tokenId), BigInt.from(duration)]),
        chainId: 1337);
  }

  Future<void> getSubscriptions() async {
    await init();
    List nftList = await _web3client!.call(
        contract: _deployedContract!, function: _getSubscriptions!, params: []);
    _nfts = nftList[0];
    nftList[0].removeAt(0);
    _nfts = nftList[0];
    _nfts.removeWhere(
        (item) => item[1] == EthereumAddress.fromHex(genesisAddress));

    notifyListeners();
  }

  Future<void> buySubscription(int tokenId, BigInt price) async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            value: EtherAmount.fromBigInt(EtherUnit.wei, price),
            from: EthereumAddress.fromHex(dummyAddress),
            contract: _deployedContract!,
            function: _buySubscription!,
            parameters: [BigInt.from(tokenId)]),
        chainId: 1337);
    getCollectables(dummyAddress);
  }

  Future<void> renewSubscription(int tokenId, int duration) async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            nonce: await _web3client!
                .getTransactionCount(EthereumAddress.fromHex(dummyAddress)),
            from: EthereumAddress.fromHex(dummyAddress),
            contract: _deployedContract!,
            function: _renewSubscription!,
            parameters: [BigInt.from(tokenId), BigInt.from(duration)]),
        chainId: 1337);
    getMyNfts(dummyAddress);
  }

  Future<int> expiresAt(int tokenId) async {
    await init();
    List expiration = await _web3client!.call(
        contract: _deployedContract!,
        function: _expiresAt!,
        params: [BigInt.from(tokenId)]);
    _duration = expiration[0].toInt();
    return _duration;
  }

  Future<void> cancelSubscription(int tokenId) async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            nonce: await _web3client!
                .getTransactionCount(EthereumAddress.fromHex(dummyAddress)),
            from: EthereumAddress.fromHex(dummyAddress),
            contract: _deployedContract!,
            function: _cancelSubscription!,
            parameters: [BigInt.from(tokenId)]),
        chainId: 1337);
    getMyNfts(dummyAddress);
  }

  Future<void> likeSubscription(int tokenId) async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
          nonce: await _web3client!
              .getTransactionCount(EthereumAddress.fromHex(dummyAddress)),
          from: EthereumAddress.fromHex(dummyAddress),
          contract: _deployedContract!,
          function: _likeSubscription!,
          parameters: [BigInt.from(tokenId)],
        ),
        chainId: 1337);
    getSubscriptions();
  }

  Future<void> unlikeSubscription(int tokenId) async {
    await init();
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
          nonce: await _web3client!
              .getTransactionCount(EthereumAddress.fromHex(dummyAddress)),
          from: EthereumAddress.fromHex(dummyAddress),
          contract: _deployedContract!,
          function: _unlikeSubsription!,
          parameters: [BigInt.from(tokenId)],
        ),
        chainId: 1337);
    getSubscriptions();
  }

  Future<void> getUserProfile(EthereumAddress user) async {
    await init();
    List profileList = await _web3client!.call(
        contract: _deployedContract!, function: _profileCount!, params: []);
    BigInt totalProfiles = profileList[0];
    profileCount = totalProfiles.toInt();
    List allProfiles = [];
    for (int i = 1; i < profileCount; i++) {
      List temp = await _web3client!.call(
          contract: _deployedContract!,
          function: _profiles!,
          params: [BigInt.from(i)]);
      allProfiles.add(temp);
    }
    for (int i = 0; i < allProfiles.length; i++) {
      if (allProfiles[i][0] == user) {
        _userProfile = allProfiles[i];
      }
    }
    getMyNfts(_userProfile[0].toString());
    getCollectables(_userProfile[0].toString());
    notifyListeners();
  }
}
