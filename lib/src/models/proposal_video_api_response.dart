// To parse this JSON data, do
//
//     final proposalVideoApiResponse = proposalVideoApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wedfluencer/src/models/proposal_video.dart';

ProposalVideoApiResponse proposalVideoApiResponseFromJson(String str) =>
    ProposalVideoApiResponse.fromJson(json.decode(str));

String proposalVideoApiResponseToJson(ProposalVideoApiResponse data) =>
    json.encode(data.toJson());

class ProposalVideoApiResponse {
  final List<ProposalVideo> proposalVideos;
  final int total;
  final int approved;
  final int declined;
  final int disabled;
  final int removed;
  final int failed;

  ProposalVideoApiResponse({
    required this.proposalVideos,
    required this.total,
    required this.approved,
    required this.declined,
    required this.disabled,
    required this.removed,
    required this.failed,
  });

  factory ProposalVideoApiResponse.fromJson(Map<String, dynamic> json) =>
      ProposalVideoApiResponse(
        proposalVideos: List<ProposalVideo>.from(
            json["proposalVideos"].map((x) => ProposalVideo.fromJson(x))),
        total: json["total"],
        approved: json["approved"],
        declined: json["declined"],
        disabled: json["disabled"],
        removed: json["removed"],
        failed: json["failed"],
      );

  Map<String, dynamic> toJson() => {
        "proposalVideos":
            List<dynamic>.from(proposalVideos.map((x) => x.toJson())),
        "total": total,
        "approved": approved,
        "declined": declined,
        "disabled": disabled,
        "removed": removed,
        "failed": failed,
      };
}
