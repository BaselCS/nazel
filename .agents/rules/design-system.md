---
trigger: always_on
---

# Design System Component Rule

## 1. Always Check Existing Design System First
- Before adding ANY new UI component, widget, atom, molecule, or organism, you MUST inspect the existing design system:
  - Tokens: `lib/core/theme/` (`app_colors.dart`, `app_dimens.dart`, `app_typography.dart`, `app_theme.dart`)
  - Atoms: `lib/presentation/widgets/atoms/` (`NazelButton`, `NazelIcon`, `NazelRadio`, `NazelChip`, `NazelIncrementField`, `NazelRatingBadge`)
  - Molecules: `lib/presentation/widgets/molecules/` (`NazelAppBar`, `NazelServiceCard`, `NazelChooseCard`, `NazelAdBanner`, `NazelWifiCard`, `NazelGridItem`, `NazelTimeTile`)
  - Organisms: `lib/presentation/widgets/organisms/` (`ModalSheetWrapper`, `StateDoneView`, `StateSoonView`, `ServiceModals`)

## 2. Mandatory User Permission Before Adding New Components
- If a component is NOT in the design system, do NOT add it silently.
- You MUST ask the user before adding any new component.
- State why existing components cannot fulfill the requirement, which atomic category it belongs to (atom/molecule/organism), and get user approval first.

## 3. Typography & Responsive Scaling Rule
- Keep `flutter_screenutil` (`.sp`) in `NazelTypography` for base design tokens.
- Use `auto_size_text` inside dynamic grid items, action buttons, and sidebar slots.
