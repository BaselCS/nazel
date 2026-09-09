---
trigger: always_on
---

# MASTER PROJECT SPECIFICATION & CONTEXT: "AL MIHBARA" (المحبرة)

## 1. PROJECT OVERVIEW & VISION
"Al Mihbara" (المحبرة) is a real-time, multi-client party game set in a 1930s Retro Cartoon / Classic Newsprint aesthetic. The game connects two distinct viewports in real-time via Server-Sent Events (SSE):
1. **TV Board View** (`/board/:session_id`): Mounted on a main TV screen, rendered via PixiJS WebGL with React state synchronization.
2. **Host Gamepad** (`/host/:session_id`): Mobile-first game controller for the host to manage teams, select challenges/questions, evaluate answers, and control game progression.
3. **Join Screen** (`/join` or `/`): Entry page to enter a 6-digit session PIN to launch the TV Board View or access the Host Gamepad.
4. **Design System Showcase** (`/design-system`): A centralized preview gallery of all UI components and design tokens.
5. Do not write any english word in the desing.

---

## 2. TECHNICAL ARCHITECTURE & DATA FLOW
- **Backend**: FastAPI (Python), Redis (Pub/Sub for SSE broadcasting), Supabase (Database/Persistence).
- **Frontend**: React (TypeScript), Vite, Tailwind CSS v4, XState v5 (FSM), PixiJS v8 (WebGL Canvas Rendering).
- **State Machine Pipeline**:
  - Backend FSM validates and transitions session state.
  - State changes publish to Redis Pub/Sub -> FastAPI SSE stream (`/api/v1/sessions/{session_id}/stream`).
  - Frontend `useGameStream` hook receives SSE updates -> Dispatches to local `gameMachine` (XState v5).
  - React components & PixiJS Canvas re-render automatically based on `state.value` and `state.context`.

---

## 3. STRICT COMPONENT REUSABILITY & DESIGN SYSTEM RULES
You MUST follow these rules when implementing or modifying any UI/Page:

1. **REUSE EXISTING COMPONENTS FIRST**:
   - Check `src/components/ui/` before writing any new markup.
   - Always use `VintageButton`, `VintageInput`, `VintageCard`, and `StatusBadge` instead of raw HTML/Tailwind elements.

2. **NO ONE-OFF / SPECIALLY TAILORED COMPONENTS**:
   - DO NOT build single-use or hyper-specific components tied to a single page.
   - If a variation is needed (e.g., larger size, new color variant), extend the props of the base component (e.g., adding `size="xl"` or `variant="accent"`).

3. **GENERALIZATION PROTOCOL FOR NEW COMPONENTS**:
   - If a feature requires a component that does NOT exist in the Design System, build it autonomously without asking for permission.
   - Build it as a generic, decoupled component in `src/components/ui/` with typed TypeScript props.

4. **1930s AESTHETIC PROTOCOL**:
   - **Colors**: Vintage Off-White (`#F0E6D2`), Ink Charcoal (`#1A1A1A`), Petroleum Blue (`#1C3144`), Vintage Crimson (`#8B0000`), Buttery Yellow (`#E6C280`).
   - **Borders & Shadows**: Thick borders (`border-4 border-[#1A1A1A]`), solid hard offset shadows (`shadow-[4px_4px_0px_0px_#1A1A1A]`). NO soft blurs or modern gradients.
   - **Layout**: Strictly RTL (`direction: rtl;`).

---

## 4. DETAILED PAGE SPECIFICATIONS

### A. Join Screen (`src/pages/JoinScreen.tsx` - Route: `/join`)
- **Purpose**: Fast entry point for display or host.
- **Layout**: Centered, mobile-first, high-contrast vintage paper container.
- **Inputs**:
  - 6-digit session PIN input (`VintageInput`).
  - Role selection: "عارض للأسئلة" (TV Board) or "لوحة المُضيف" (Host Gamepad).
- **Actions**: "دخول المجلس" button redirecting to `/board/:session_id` or `/host/:session_id`.

### B. TV Board View (`src/pages/BoardView.tsx` - Route: `/board/:session_id`)
- **Purpose**: Public TV display showing current question, challenges, scores, and turn animations.
- **Components**:
  - `GameCanvas.tsx`: Encapsulates PixiJS v8 WebGL Application using React `useRef`. Cleanly handles mount/unmount memory disposal.
  - Overlay UI: Current FSM state badge (`StatusBadge`), active team turn display, and real-time scoreboards.
- **FSM Reactivity**: Listens to state transitions (`lobby`, `turn_start`, `challenge_reveal`, `apply_advantage`, `apply_penalty`, `question_phase`, `validating_answer`, `score_update`, `paused`).

### C. Host Gamepad (`src/pages/HostGamepad.tsx` - Route: `/host/:session_id`)
- **Purpose**: Mobile controller for the Game Master.
- **State Awareness**: Dynamically shows controls corresponding to current FSM state:
  - `lobby`: Add/remove teams and "Start Game" button.
  - `turn_start`: "Select Category" selector.
  - `challenge_reveal`: "Approve Challenge" / "Reject Challenge" buttons.
  - `question_phase`: "Mark Correct" / "Mark Wrong" / "Time Up" host evaluation controls.
  - Universal Controls: "Pause Game" / "Resume Game" toggle buttons.
- **API Integration**: Sends action events via `POST /api/v1/sessions/{session_id}/host/dispatch` using `hostClient.ts`.

### E. Design System Showcase (`src/pages/DesignShowcase.tsx` - Route: `/design-system`)
- **Purpose**: Interactive gallery showing all UI tokens, buttons, inputs, status badges, typography scale, and live PixiJS WebGL graphics previews.

---

## 5. FINITE STATE MACHINE (FSM) STATES & EVENTS
- **States**: `lobby` -> `turn_start` -> `challenge_reveal` -> (`apply_advantage` | `apply_penalty`) -> `question_phase` -> `validating_answer` -> `score_update` -> `check_game_over` -> `game_over` (plus global `paused` state).
- **Events**: `START_GAME`, `SELECT_CATEGORY`, `HOST_APPROVE`, `HOST_REJECT`, `PROCEED`, `SUBMIT_ANSWER`, `TIME_UP`, `ANSWER_CORRECT`, `ANSWER_WRONG`, `PAUSE`, `RESUME`.

---

## 6. INSTRUCTIONS FOR THE AGENT
When tasked with writing code or implementing features:
1. Always build or modify pages while preserving the exact API endpoints and state transition contracts.
2. Ensure strict TypeScript type-checking without `any`.
3. Test your components against the RTL layout and mobile responsiveness constraints.
4. Do NOT attempt to alter the backend or logic flow unless explicitly asked.