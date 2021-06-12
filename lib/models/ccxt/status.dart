import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

enum StatusType { ok, shutdown, error, maintenance, unknown }

@JsonSerializable()
class Status {
  Status(this.status, this.updated, this.eta, this.url);
  Status.empty()
      : status = StatusType.unknown,
        updated = null,
        eta = null,
        url = null;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  StatusType status;
  int? updated;
  dynamic eta;
  dynamic url;

  static StatusType _statusFromJson(dynamic value) {
    switch (value) {
      case 'ok':
        return StatusType.ok;
      case 'shutdown':
        return StatusType.shutdown;
      case 'error':
        return StatusType.error;
      case 'maintenance':
        return StatusType.maintenance;
      default:
        return StatusType.unknown;
    }
  }

  static String _statusToJson(StatusType value) {
    switch (value) {
      case StatusType.ok:
        return 'ok';
      case StatusType.shutdown:
        return 'shutdown';
      case StatusType.error:
        return 'error';
      case StatusType.maintenance:
        return 'maintenance';
      default:
        return 'unknown';
    }
  }
}
