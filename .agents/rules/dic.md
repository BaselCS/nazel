---
trigger: model_decision
description: write a label 
---

# RULE: DOMAIN DICTIONARY & TERMINOLOGY ENFORCEMENT

You MUST strictly adhere to the standardized terminology and domain vocabulary defined in `dictionary.md` located in the root directory.

1. **MANDATORY DICTIONARY CONSULTATION:**
   - Before writing or modifying any UI text, error messages, API response payloads, code comments, or database field descriptions, you MUST inspect `dictionary.md`.
   - Read and apply all defined terms, Arabic translations, and domain jargon.

2. **STRICT TERMINOLOGY ADHERENCE:**
   - ALWAYS use the exact words, phrases, and translations listed in `dictionary.md`.
   - DO NOT invent synonyms, localized variations, or alternative translations for terms already defined in the dictionary (e.g., if "Lobby" is defined as "الردهة", NEVER use "غرفة الانتظار" or "الصالة").

3. **CONSISTENCY ACROSS STACK:**
   - Ensure complete alignment between frontend UI text, backend state messages, and user notifications according to `dictionary.md`.

4. **MISSING TERMS PROTOCOL:**
   - If a new UI text or domain concept is required that is NOT present in `dictionary.md`, use a clear, neutral convention matching the existing dictionary style, or flag it for addition to `dictionary.md`.