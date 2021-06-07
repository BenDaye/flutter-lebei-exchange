import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

enum StatusType { OK, SHUTDOWN, ERROR, MAINTENANCE, UNKNOWN }

@JsonSerializable()
class Status {
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  StatusType status;
  int? updated;
  dynamic eta;
  dynamic url;

  Status(this.status, this.updated, this.eta, this.url);

  static StatusType _statusFromJson(dynamic value) {
    switch (value) {
      case 'ok':
        return StatusType.OK;
      case 'shutdown':
        return StatusType.SHUTDOWN;
      case 'error':
        return StatusType.ERROR;
      case 'maintenance':
        return StatusType.MAINTENANCE;
      default:
        return StatusType.UNKNOWN;
    }
  }

  static String _statusToJson(StatusType value) {
    switch (value) {
      case StatusType.OK:
        return 'ok';
      case StatusType.SHUTDOWN:
        return 'shutdown';
      case StatusType.ERROR:
        return 'error';
      case StatusType.MAINTENANCE:
        return 'maintenance';
      default:
        return 'unknown';
    }
  }

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  Map<String, dynamic> toJson() => _$StatusToJson(this);

  static Status empty() => Status(StatusType.UNKNOWN, null, null, null);
}
