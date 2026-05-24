import 'questionnaire_models.dart';

List<QuestionSection> buildSections() {
  return [
    QuestionSection(
      title: 'Section A — Risk Factors',
      subtitle: 'Lifestyle, exposures, and medical history associated with oral cancer',
      icon: '🔍',
      questions: [
        QuestionItem(
          id: 'c1',
          text: 'Do you currently smoke or use tobacco products (cigarettes, cigars, pipe, bidis)?',
          hint: 'Includes past use within the last 10 years',
        ),
        QuestionItem(
          id: 'c2',
          text: 'Do you use smokeless tobacco — chewing tobacco, snuff, or gutkha?',
        ),
        QuestionItem(
          id: 'c3',
          text: 'Do you chew betel nut (areca nut) or pan, with or without tobacco?',
        ),
        QuestionItem(
          id: 'c4',
          text: 'Do you consume alcohol regularly?',
          hint: 'More than 14 units/week (men) or 7 units/week (women)',
        ),
        QuestionItem(
          id: 'c5',
          text: 'Do you have a known HPV (Human Papillomavirus) infection, or have you been told you are at elevated risk?',
          hint: 'HPV-16 is associated with oropharyngeal cancers',
        ),
        QuestionItem(
          id: 'c6',
          text: 'Are you frequently exposed to prolonged sunlight or UV radiation without lip protection?',
          hint: 'Relevant for labial (lip) carcinoma',
        ),
        QuestionItem(
          id: 'c7',
          text: 'Do you have a family history of oral cancer or head and neck cancers?',
        ),
        QuestionItem(
          id: 'c8',
          text: 'Do you have a personal history of prior oral lesions, dysplasia, or head and neck cancer?',
        ),
        QuestionItem(
          id: 'c9',
          text: 'Are you immunocompromised or on long-term immunosuppressant medications?',
          hint: 'E.g., organ transplant recipients, HIV/AIDS, long-term steroids',
        ),
      ],
    ),
    QuestionSection(
      title: 'Section B — Symptoms',
      subtitle: 'Signs and presentations associated with oral cancer',
      icon: '🩺',
      questions: [
        QuestionItem(
          id: 's1',
          text: 'Do you have any sores or ulcers in your mouth that have not healed within 3 weeks?',
          diffQuestions: [
            DiffQuestion(
              id: 'd1',
              text: 'Did the sore appear within a few days of starting a new medication, dental procedure, or allergic exposure?',
              hint: 'Points toward drug reaction, contact stomatitis, or fixed drug eruption',
            ),
            DiffQuestion(
              id: 'd2',
              text: 'Does the ulcer recur periodically and heal completely on its own within 1–2 weeks each time?',
              hint: 'A recurring, self-resolving pattern is characteristic of aphthous ulcers (canker sores)',
            ),
            DiffQuestion(
              id: 'd3',
              text: 'Did the sore begin as painful clusters of small blisters, possibly preceded by a tingling or burning sensation?',
              hint: 'Suggests herpes simplex virus (HSV) or herpes zoster reactivation',
            ),
          ],
        ),
        QuestionItem(
          id: 's2',
          text: 'Have you noticed any red (erythroplakia) or white (leukoplakia) patches inside your mouth that will not scrape off?',
          diffQuestions: [
            DiffQuestion(
              id: 'd4',
              text: 'Can the white coating be easily wiped off with a piece of gauze or a cloth?',
              hint: 'Removable white material strongly suggests oral candidiasis (thrush) rather than leukoplakia',
            ),
            DiffQuestion(
              id: 'd5',
              text: 'Does the patch correspond exactly to an area of repeated local trauma — e.g., a sharp tooth edge, ill-fitting denture, or habitual cheek biting?',
              hint: 'Traumatic keratosis can mimic early leukoplakia',
            ),
            DiffQuestion(
              id: 'd6',
              text: 'Do you notice a lace-like or net-like white pattern (fine white lines) on your inner cheeks or gums rather than a solid patch?',
              hint: 'Wickham\'s striae — a reticular pattern — are characteristic of oral lichen planus',
            ),
          ],
        ),
        QuestionItem(
          id: 's3',
          text: 'Do you have a lump, thickening, or persistent rough patch in your mouth, on your lip, or in your throat?',
          diffQuestions: [
            DiffQuestion(
              id: 'd7',
              text: 'Is the lump or swelling tender to touch, and did it appear shortly after a dental infection, sore throat, or upper respiratory illness?',
              hint: 'Tender, post-infection swelling is typical of reactive lymphadenopathy, not malignancy',
            ),
            DiffQuestion(
              id: 'd8',
              text: 'Has a clinician previously examined this lump and given a confirmed benign diagnosis?',
              hint: 'E.g., fibroma, mucocele, salivary gland swelling, lipoma',
            ),
          ],
        ),
        QuestionItem(id: 's4', text: 'Do you have persistent pain or soreness in your mouth, tongue, or throat without an obvious cause?'),
        QuestionItem(
          id: 's5',
          text: 'Have you experienced unexplained difficulty chewing, swallowing, or moving your tongue or jaw?',
          hint: 'Trismus or dysphagia without apparent dental cause',
        ),
        QuestionItem(id: 's6', text: 'Have you had unexplained numbness or loss of feeling in any part of your mouth, face, or neck?'),
        QuestionItem(id: 's7', text: 'Do you have a hoarse voice or persistent sore throat that has lasted more than 3 weeks?'),
        QuestionItem(id: 's8', text: 'Have you noticed a swollen lymph node or lump in your neck that has persisted for more than 3 weeks?'),
        QuestionItem(id: 's9', text: 'Have you had unexplained weight loss — without dieting — in the past 3 months?'),
      ],
    ),
  ];
}
