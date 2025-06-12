class ResponseModel {
  final String? _message;
  final bool _isSuccess;
  final int? otp;


  ResponseModel(this._message, this._isSuccess, {this.otp});

  bool get isSuccess => _isSuccess;
  String? get message => _message;

}