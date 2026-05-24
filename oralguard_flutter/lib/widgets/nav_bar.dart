import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class OralGuardNavBar extends StatelessWidget implements PreferredSizeWidget {
  const OralGuardNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final isMobile = Bp.isMobile(context);

    return AppBar(
      backgroundColor: AppColors.cream.withOpacity(0.97),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColors.border,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 56,
      title: Row(
        children: [
          // Logo — always visible
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.rust,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Oral',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18, color: AppColors.ink,
                        ),
                      ),
                      TextSpan(
                        text: 'Guard',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18, color: AppColors.rust,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Hide text nav on mobile — bottom nav handles it
          if (!isMobile) ...[
            _NavChip(label: 'Home',    route: '/',        active: location == '/'),
            const SizedBox(width: 4),
            _NavChip(label: 'Screener', route: '/screener', active: location == '/screener'),
            const SizedBox(width: 4),
            _NavChip(label: 'Matcher', route: '/matcher', active: location == '/matcher'),
          ],
        ],
      ),
    );
  }
}

class _NavChip extends StatelessWidget {
  final String label;
  final String route;
  final bool active;

  const _NavChip({required this.label, required this.route, required this.active});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: active ? AppColors.rustLight : Colors.transparent,
          border: Border.all(
            color: active ? AppColors.rustLight : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: GoogleFonts.sourceSans3(
            fontSize: 13,
            color: active ? AppColors.rust : AppColors.muted,
            fontWeight: active ? FontWeight.w600 : FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

// ─── Bottom nav for mobile ────────────────────────────────────────────────────

class OralGuardBottomNav extends StatelessWidget {
  const OralGuardBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int index = 0;
    if (location == '/screener') index = 1;
    if (location == '/matcher') index = 2;

    return NavigationBar(
      backgroundColor: AppColors.cream,
      indicatorColor: AppColors.rustLight,
      selectedIndex: index,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      onDestinationSelected: (i) {
        switch (i) {
          case 0: context.go('/'); break;
          case 1: context.go('/screener'); break;
          case 2: context.go('/matcher'); break;
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: AppColors.rust),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.assignment_outlined),
          selectedIcon: Icon(Icons.assignment, color: AppColors.rust),
          label: 'Screener',
        ),
        NavigationDestination(
          icon: Icon(Icons.image_search_outlined),
          selectedIcon: Icon(Icons.image_search, color: AppColors.rust),
          label: 'Matcher',
        ),
      ],
    );
  }
}