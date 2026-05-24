import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';

class SelfExamScreen extends StatelessWidget {
  const SelfExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('01', 'Lips & Corners',
          'Pull lips away from teeth. Look for sores or colour changes on the lips and corners.'),
      ('02', 'Inner Cheeks & Gums',
          'Pull each cheek sideways. Look for red, white, or mixed patches. Feel for lumps.'),
      ('03', 'Tongue — All Sides',
          'Stick out tongue. Check top, then inspect sides and underside — the most common cancer site.'),
      ('04', 'Floor of Mouth',
          'Press tongue to roof of mouth. Check underneath for swelling, sores, or colour changes.'),
      ('05', 'Palate (Roof)',
          'Tilt head back, open wide. Look for lumps or changes on the hard and soft palate.'),
      ('06', 'Throat & Neck',
          'Say "Aah" and check the back of your throat. Feel along your neck for enlarged lymph nodes.'),
    ];

    final signsLeft = [
      'Sore not healed in 3 weeks',
      'Lump or rough thickening',
      'Difficulty chewing or swallowing',
      'Swollen neck node 3+ weeks',
    ];

    final signsRight = [
      "Red or white patch that won't wipe off",
      'Persistent pain or numbness',
      'Hoarse voice lasting 3+ weeks',
      'Unexplained weight loss',
    ];

    final isMobile = Bp.isMobile(context);
    final hPad = isMobile ? 16.0 : 24.0;
    final fs = fontScale(context);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream.withOpacity(0.97),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: AppColors.ink,
          onPressed: () => context.go('/'),
        ),
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Oral',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 18, color: AppColors.ink)),
            TextSpan(
                text: 'Guard',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 18, color: AppColors.rust)),
          ]),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.ink),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── TITLE ──────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, 20, hPad, 0),
              child: Text(
                'Oral Self-Examination Guide',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24 * fs,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
            ),

            // ── DIAGRAM ────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, 18, hPad, 0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: AspectRatio(
                  aspectRatio: isMobile ? 1.0 : 1.4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Image.asset(
                        'assets/images/self_exam_diagram.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.rustLight,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.image_not_supported_outlined,
                                    size: 32, color: AppColors.rust),
                                const SizedBox(height: 8),
                                Text('Diagram unavailable',
                                    style: GoogleFonts.sourceSans3(
                                        fontSize: 13, color: AppColors.rust)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── CAPTION ────────────────────────────────────────────────────
            const SizedBox(height: 14),
            const Divider(height: 1, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  'Check all highlighted areas monthly — takes 5 minutes',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSans3(
                      fontSize: 12 * fs, color: AppColors.muted),
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 14),

            // ── STEP GRID ──────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad - 4),
              child: _StepGrid(steps: steps),
            ),
            const SizedBox(height: 24),

            // ── WARNING SIGNS ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report any of these to a dentist:',
                    style: GoogleFonts.sourceSans3(
                      fontSize: 14 * fs,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // On very small screens stack vertically
                  isMobile && Bp.isXSmall(context)
                      ? Column(
                          children: [
                            ...signsLeft.map((s) => _BulletItem(text: s)),
                            ...signsRight.map((s) => _BulletItem(text: s)),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: signsLeft
                                    .map((s) => _BulletItem(text: s))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: signsRight
                                    .map((s) => _BulletItem(text: s))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ── CLOSE BUTTON ───────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 36),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    elevation: 0,
                  ),
                  child: Text(
                    'CLOSE GUIDE',
                    style: GoogleFonts.sourceSans3(
                      fontSize: 13 * fs,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 2-column step grid ───────────────────────────────────────────────────────

class _StepGrid extends StatelessWidget {
  final List<(String, String, String)> steps;
  const _StepGrid({required this.steps});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < steps.length; i += 2) {
      final left = steps[i];
      final right = i + 1 < steps.length ? steps[i + 1] : null;
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _StepCard(num: left.$1, title: left.$2, desc: left.$3),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: right != null
                ? _StepCard(num: right.$1, title: right.$2, desc: right.$3)
                : const SizedBox.shrink(),
          ),
        ],
      ));
      rows.add(const SizedBox(height: 10));
    }
    return Column(children: rows);
  }
}

class _StepCard extends StatelessWidget {
  final String num;
  final String title;
  final String desc;
  const _StepCard({required this.num, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    final fs = fontScale(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDE6),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(num,
              style: GoogleFonts.sourceSans3(
                  fontSize: 13 * fs,
                  fontWeight: FontWeight.w400,
                  color: AppColors.rust.withOpacity(0.6))),
          const SizedBox(height: 4),
          Text(title,
              style: GoogleFonts.sourceSans3(
                  fontSize: 13 * fs,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink)),
          const SizedBox(height: 5),
          Text(desc,
              style: GoogleFonts.sourceSans3(
                  fontSize: 12 * fs, color: AppColors.muted, height: 1.55)),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    final fs = fontScale(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 8),
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                  color: AppColors.rust, shape: BoxShape.circle),
            ),
          ),
          Expanded(
            child: Text(text,
                style: GoogleFonts.sourceSans3(
                    fontSize: 13 * fs, color: AppColors.muted, height: 1.5)),
          ),
        ],
      ),
    );
  }
}