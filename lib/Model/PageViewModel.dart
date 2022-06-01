class PageViewModel{
  var _id;
  String _imgUrl;

  PageViewModel(this._id, this._imgUrl);

  String get imgUrl => _imgUrl;

  get id => _id;
}