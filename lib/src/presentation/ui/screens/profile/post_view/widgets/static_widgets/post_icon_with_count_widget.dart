part of 'post_details.dart';

class _PostIconWithCountWidget extends StatelessWidget {
  const _PostIconWithCountWidget({
    required this.iconName,
    required this.count,
    this.isInverted = false,
  });

  final String iconName;
  final String count;
  final bool isInverted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: isInverted ? 2 : 0,
            child: SvgPicture.asset(
              'assets/svg/$iconName.svg',
              semanticsLabel: iconName,
              color: Colors.black,
              width: 20,
            ),
          ),
          // Icon(icon, size: 22),
          Text('  $count', style: ScreenConfig.theme.textTheme.titleSmall)
        ],
      ),
    );
  }
}
