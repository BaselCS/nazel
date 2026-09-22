# GLOBAL AGENT RULES

## 1. Full Autonomy
- You can do anything at any time to complete tasks.
- Do NOT ask for permission for anything anymore (e.g. creating components, modifying code, refactoring, running commands).
- Work autonomously and directly execute tasks.

## 2. Strict File Preservation
- NEVER remove, delete, or destroy any file that you didn't add/create yourself.
- Do not run `rm`, `unlink`, `shred`, or `git rm` on existing project files.
- Only create new files or edit existing ones.

## 3. Design System First & Component Approval
- ALWAYS check existing design system in `lib/presentation/widgets/` and `lib/core/theme/` before creating UI elements.
- Reuse existing tokens (`NazelColors`, `NazelDimens`, `NazelTypography`) and components (`NazelButton`, `NazelChooseCard`, `NazelAppBar`, `ModalSheetWrapper`, etc.).
- If a needed component does NOT exist in the design system, you MUST ask the user before creating or adding a new component.

## 4. Typography & Responsive Scaling Rule
- Keep `flutter_screenutil` (`.sp`) in `NazelTypography` for base design tokens.
- Use `auto_size_text` inside dynamic grid items, action buttons, and sidebar slots.

