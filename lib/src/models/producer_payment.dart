class ProducerPayment {
  final String id;
  final String referralCode;
  final String title;
  final List<ProposalVideo> proposalVideos;
  final int proposalVideosCount;
  final int proposalVideosPaymentCount;
  final double totalPaymentsSum;

  ProducerPayment({
    required this.id,
    required this.referralCode,
    required this.title,
    required this.proposalVideos,
    required this.proposalVideosCount,
    required this.proposalVideosPaymentCount,
    required this.totalPaymentsSum,
  });

  factory ProducerPayment.fromJson(Map<String, dynamic> json) =>
      ProducerPayment(
        id: json["id"],
        referralCode: json["referralCode"],
        title: json["title"],
        proposalVideos: List<ProposalVideo>.from(
            json["proposalVideos"].map((x) => ProposalVideo.fromJson(x))),
        proposalVideosCount: json["proposalVideosCount"],
        proposalVideosPaymentCount: json["proposalVideosPaymentCount"],
        totalPaymentsSum: json["totalPaymentsSum"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "referralCode": referralCode,
        "title": title,
        "proposalVideos":
            List<dynamic>.from(proposalVideos.map((x) => x.toJson())),
        "proposalVideosCount": proposalVideosCount,
        "proposalVideosPaymentCount": proposalVideosPaymentCount,
        "totalPaymentsSum": totalPaymentsSum,
      };
}

class ProposalVideo {
  final String id;
  final String status;
  final List<Payment> payments;

  ProposalVideo({
    required this.id,
    required this.status,
    required this.payments,
  });

  factory ProposalVideo.fromJson(Map<String, dynamic> json) => ProposalVideo(
        id: json["id"],
        status: json["status"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Payment {
  final int price;
  final String transactionId;
  final DateTime createdAt;
  final String userId;

  Payment({
    required this.price,
    required this.transactionId,
    required this.createdAt,
    required this.userId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        price: json["price"],
        transactionId: json["transactionId"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "transactionId": transactionId,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId,
      };
}
