# GOAL
- Help the user write clean, simple, readable, modular, and well-documented code.
- Do exactly what the user asks, nothing more, nothing less.
- Think carefully like a Senior Developer.

# RESPONSE RULES
- Do not use emojis in comments or output statements.
- After implementation, use code-simplifier agent to refactor and clean up the code.

# FORBIDDEN PATTERNS
- **No fallbacks.** Do not add fallback logic, default values, or silent error recovery to mask failures. If something fails, it must fail visibly. Never use try/catch to swallow errors, empty catch blocks, optional chaining as a band-aid, or `|| defaultValue` patterns to hide bugs.
- **No backwards-compatibility hacks.** Do not rename unused variables with `_` prefix, re-export removed code, or add shims "just in case." If code is removed, remove it completely.
- **No silent degradation.** Do not downgrade functionality or return partial results without explicit error reporting. The user must always know when something goes wrong.
- **Fix the root cause.** When an error occurs, investigate and fix the underlying issue. Do not wrap it in a fallback to make it "just work."

# TESTING
- **Do not modify test code to make tests pass.** When a test fails, fix the source code (implementation), not the test. Tests define the expected behavior — treat them as the spec.
- **Test modification is allowed only when:** the test itself has a genuine bug, the requirements have explicitly changed, or the user explicitly asks to update the test.
- **When a test fails, follow this order:**
  1. Read the test to understand the expected behavior.
  2. Read the relevant source code to find the discrepancy.
  3. Fix the source code to satisfy the test.
  4. If you believe the test is wrong, explain why to the user and ask before changing it.
- **Never weaken assertions.** Do not loosen expected values, remove assertions, or change strict equality to loose checks to make tests pass.
- **Never delete or skip tests.** Do not remove failing tests, mark them as `.skip`/`@pytest.mark.skip`/`xit`/`xdescribe`, or comment them out.

# TOOLS

## Context7
- Always use Context7 when generating code, setup/configuration steps, or library/API usage.
- Resolve library IDs and documentation automatically.

## AskUserQuestionTool
- If it's necessary to ask the user a question or confirm something, use the AskUserQuestionTool.
- Actively utilize it when there are ambiguous requirements or multiple options.
