# OralGuard — Oral Cancer Screening Platform

A lightweight, browser-based educational platform for early oral cancer awareness. Three interconnected tools help users self-examine, assess their risk, and visually compare lesion images against clinical cases — all without any backend infrastructure.

> **Medical disclaimer:** OralGuard is a research and educational tool. It does not provide medical diagnoses. Any persistent or unexplained change lasting over 3 weeks should be evaluated by a qualified dentist, oral surgeon, or oncologist.

---

## Features

### Self-Exam Guide (`index.html`)
A step-by-step illustrated popup guide — drawn from the 8-panel oral anatomy diagram — walks users through systematically inspecting their own mouth at home in about 5 minutes. Covers lips, gingiva, buccal mucosa, hard and soft palate, tongue (dorsal, ventral, and lateral borders), and the floor of the mouth. A warning signs checklist (e.g. sores not healing in 3 weeks, unexplained lumps, persistent hoarseness) is included.

### Risk Screener (`Questionnaire.html`)
An 18-question clinical questionnaire that weighs established oral cancer risk factors:
- Tobacco use (smoked and smokeless)
- Alcohol consumption
- HPV exposure history
- Nine key symptoms (pain, dysphagia, patches, neck nodes, weight loss, etc.)

Intelligent conditional follow-up questions help differentiate oral cancer presentations from benign conditions, and the tool outputs a personalised risk result at the end.

### Image Matcher (`matcher.html`)
An AI-powered visual comparison tool. Users upload a photo of an oral lesion; the tool finds the most visually similar benign and malignant cases from an indexed clinical image database using the Anthropic Claude API. Results surface side-by-side comparisons to help users understand what clinicians look for — not to replace clinical judgment.

---

## File Structure

```
├── index.html          # Landing page + Self-Exam Guide modal
├── Questionnaire.html  # Risk screener questionnaire
├── matcher.html        # AI image matcher
└── oral_anatomy.png    # 8-panel oral anatomy reference diagram (A–H)
```

All pages share a common design system defined via CSS custom properties and use no build tooling — open any file directly in a browser.

---

## Design System

| Token | Value | Usage |
|---|---|---|
| `--cream` | `#f8f4ee` | Page background |
| `--ink` | `#1a1208` | Body text |
| `--rust` | `#b84c2a` | Primary accent, CTAs |
| `--sage` | `#4a7c6b` | Secondary accent |
| `--muted` | `#7a6e63` | Supporting text |

Typography: **Playfair Display** (headings) + **Source Sans 3** (body), loaded from Google Fonts.

---

## Getting Started

No build step or server required.

```bash
# Clone or download the repository
git clone https://github.com/your-org/oralguard.git
cd oralguard

# Open in browser
open index.html
# or just double-click index.html in your file manager
```

For the **Image Matcher** to work, an Anthropic API key must be accessible in the environment. The `matcher.html` calls `https://api.anthropic.com/v1/messages` via `fetch` using the `claude-sonnet-4-20250514` model.

---

## Dependencies

All dependencies are loaded from CDN — no `npm install` needed.

| Dependency | Source | Used in |
|---|---|---|
| Playfair Display + Source Sans 3 | Google Fonts | All pages |
| Anthropic Claude API | `api.anthropic.com` | `matcher.html` |

