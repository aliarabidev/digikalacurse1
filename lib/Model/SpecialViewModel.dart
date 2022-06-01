class SpecialViewModel{
  var _id;
  String _productName;
  var _price;
  var _offPrice;
  var _offPrecent;
  String _imgUrl;

  SpecialViewModel(this._id, this._productName, this._price, this._offPrice,
      this._offPrecent, this._imgUrl);

  String get imgUrl => _imgUrl;

  get offPrecent => _offPrecent;

  get offPrice => _offPrice;

  get price => _price;

  String get productName => _productName;

  get id => _id;
}