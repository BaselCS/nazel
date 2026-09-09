---
trigger: always_on
---

# RULE: COMPONENT REUSABILITY & DESIGN SYSTEM INTEGRITY

When building, updating, or styling UI elements, you MUST strictly adhere to the following rules regarding components:

1. **REUSE EXISTING COMPONENTS FIRST:**
   - Always check `frontend/src/components/` (and its subdirectories) before creating any element.
   - You MUST use existing Design System components (e.g., `VintageButton`, `VintageInput`, `VintageCard`, `StatusBadge`) instead of writing raw Tailwind/HTML elements for UI controls.

2. **NO ONE-OFF / SPECIALLY TAILORED COMPONENTS:**
   - DO NOT build single-use or hyper-specific components tied to a single page or state unless explicitly authorized.
   - If a generic variation is needed (e.g., a larger button size, a different color variant), extend the props of the existing base component (e.g., adding a `size="xl"` or `variant="accent"` prop).

3. **GENERALIZATION PROTOCOL FOR NEW COMPONENTS:**
   - If a feature requires a component that does NOT exist in the Design System, build it autonomously without asking for permission.
   - Design it as a **highly reusable, generic UI component**.
   - Keep it decoupled from specific FSM states or domain logic.
   - Place it in the generic components library (e.g., `src/components/ui/`) with clean TypeScript props so it can be reused anywhere in the app.