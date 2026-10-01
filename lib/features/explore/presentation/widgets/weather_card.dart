import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/explore_feed.dart';

extension WeatherConditionUi on WeatherCondition {
  String label(AppLocalizations l) => switch (this) {
    WeatherCondition.sunny => l.weatherSunny,
    WeatherCondition.partlyCloudy => l.weatherPartlyCloudy,
    WeatherCondition.cloudy => l.weatherCloudy,
    WeatherCondition.rainy => l.weatherRainy,
    WeatherCondition.snowy => l.weatherSnowy,
  };
}

/// Hafta sonu hava durumu kartı. Ok, müsait bungalovlara götürür.
class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.weather, required this.onOpen});

  final WeatherSummary weather;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final dayLine = l.weatherDayCondition(
      KzFormat.weekday(weather.date),
      weather.condition.label(l),
    );
    final message = weather.condition == WeatherCondition.sunny
        ? l.weatherPoolDay(weather.availableCount)
        : l.weatherAvailable(weather.availableCount);

    return Container(
      padding: const EdgeInsets.all(KzSpace.s18),
      decoration: BoxDecoration(
        color: kz.apricotSoft,
        borderRadius: KzRadii.all(KzRadii.lg),
      ),
      child: Row(
        children: [
          Container(
            width: KzSize.tile,
            height: KzSize.tile,
            decoration: BoxDecoration(
              color: kz.apricot,
              borderRadius: KzRadii.all(KzRadii.field),
            ),
            alignment: Alignment.center,
            // Güneş ikonu yalnızca güneşli günler için tasarlandı.
            child: KzIcon(
              KzIcons.sun,
              size: KzSize.iconHero,
              color: kz.onForest,
            ),
          ),
          const SizedBox(width: KzSpace.s14),
          Expanded(
            child: Semantics(
              container: true,
              label:
                  '${l.weatherTemperature(weather.temperatureC)}, $dayLine. $message',
              child: ExcludeSemantics(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: KzSpace.s6,
                      children: [
                        Text(
                          l.weatherTemperature(weather.temperatureC),
                          style: KzText.h4.copyWith(
                            color: kz.ink,
                            letterSpacing: KzText.h3.letterSpacing,
                          ),
                        ),
                        Text(
                          dayLine,
                          style: KzText.label.copyWith(color: kz.apricotText),
                        ),
                      ],
                    ),
                    const SizedBox(height: KzSpace.s4),
                    Text(
                      message,
                      style: KzText.labelMedium.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: KzSpace.s14),
          KzCircleButton(
            icon: KzIcons.arrow,
            semanticLabel: message,
            onPressed: onOpen,
          ),
        ],
      ),
    );
  }
}
