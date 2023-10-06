import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gpt/app/ui/widgets/revo_screen_header.dart";
import "package:floating_action_bubble/floating_action_bubble.dart";


class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

  

  }
  late Animation<double> _animation;

  @override
  Widget build(final BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Column(
          children: [
            RevoScreenHeader(
              title: 'AppLocalizations.of(context).vehicles',
              actions: TextField(
                decoration: InputDecoration(
                  hintText: 'AppLocalizations.current.search',
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                  ),
                ),
                onChanged: (final text) {
                
                },
              ),
            ),
           
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FloatingActionBubble(
            animation: _animation,
            items: <Bubble>[
              Bubble(
                title: 'AppLocalizations.of(context).manually_add',
                iconColor: Theme.of(context).colorScheme.primary,
                bubbleColor: Theme.of(context).colorScheme.primaryContainer,
                icon: Icons.directions_car_filled_outlined,
                titleStyle: Theme.of(context).textTheme.titleMedium!,
                onPress: () {
                
                },
              ),
              Bubble(
                title: 'AppLocalizations.of(context).scan_license',
                iconColor: Theme.of(context).colorScheme.secondary,
                bubbleColor: Theme.of(context).colorScheme.primaryContainer,
                icon: Icons.photo_camera_outlined,
                titleStyle: Theme.of(context).textTheme.titleMedium!,
                onPress: () {
                
                },
              ),
            ],
            
            onPress: () {},
            backGroundColor: Theme.of(context).colorScheme.primaryContainer,
            iconColor: Theme.of(context).colorScheme.secondary,
            iconData: Icons.add,
          ),
        ),
      ],
    );
  }
}
