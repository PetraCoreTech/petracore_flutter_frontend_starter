import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mapScreenTemplate(ProjectConfig config) => '''
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/map/presentation/controllers/map_controllers_index.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationCubit>().state;

    final markers = <Marker>{};

    final initialCameraPosition = CameraPosition(
      target: LatLng(location?.lat ?? 0, location?.lng ?? 0),
      zoom: 20,
    );

    return AppScaffold(
      appBar: AppBarV1(title: const Text('Map')),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        onTap: (latLng) => _showRedirectDialog(context, latLng),
        onLongPress: (latLng) => _showRedirectDialog(context, latLng),
      ),
    );
  }

  Future<void> _showRedirectDialog(
    BuildContext context,
    LatLng argument,
   ) async {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Redirect',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You will be redirected to your google map app for accurate directions to the selected location',
              style: theme.textTheme.bodyLarge,
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      final url = Uri(
                        scheme: 'google.navigation',
                        queryParameters: {
                          'q': '\${argument.latitude}, \${argument.longitude}',
                        },
                      );
                      launchUrl(url);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
''';
