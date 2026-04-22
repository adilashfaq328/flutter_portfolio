# Design System: The Kinetic Ethereal

### 1. Overview & Creative North Star
**Creative North Star: "The Neon Architect"**
This design system moves beyond the standard "dark mode" template to create a high-end, editorial experience for a Flutter Developer. It is defined by the tension between deep, infinite space and sharp, luminous precision. We break the "grid-box" monotony through **intentional asymmetry**, where floating glass panels overlap deep charcoal gradients, creating a sense of three-dimensional depth. The goal is to make the interface feel like a high-end mobile OS—fluid, responsive, and deeply tactile.

### 2. Colors & Surface Soul
The palette is rooted in the "Deep Sea" spectrum, utilizing the contrast between the void (`surface`) and electric bioluminescence (`primary_fixed`).

*   **The "No-Line" Rule:** Sectioning must never be achieved via 1px solid borders. Boundaries are defined through background shifts—specifically moving from `surface` to `surface_container_low`—or through the soft glow of a `tertiary` accent.
*   **Surface Hierarchy & Nesting:** Treat the UI as a series of physical layers.
    *   **Level 0 (The Void):** `surface_dim` (#041329) for the main canvas.
    *   **Level 1 (The Bedrock):** `surface_container` (#112036) for large content sections.
    *   **Level 2 (The Interactive):** `surface_container_highest` (#27354c) for cards and modals.
*   **The "Glass & Gradient" Rule:** All floating panels (like the Navbar) must utilize `surface_bright` at 40% opacity with a `backdrop-filter: blur(20px)`. 
*   **Signature Textures:** Use a linear gradient for primary CTAs transitioning from `primary_fixed` (#26fedc) to `primary_container` (#00f5d4) at a 135-degree angle. This provides a "liquid neon" feel.

### 3. Typography: Editorial Precision
We utilize two distinct voices to establish authority and technical prowess.

*   **Display & Headlines (Space Grotesk):** This is our "Technical Brand" voice. The wide apertures and geometric construction of Space Grotesk suggest modern engineering. 
    *   *Usage:* Use `display-lg` for hero impact statements. Use `headline-sm` for section titles, always set in a slightly tighter letter-spacing (-2%) to feel "premium."
*   **Interface & Body (Inter):** This is our "Utility" voice. Inter provides maximum legibility within the glass panels.
    *   *Usage:* `body-lg` for project descriptions. `label-md` (All Caps, +5% tracking) for small eyebrow text above headlines.

### 4. Elevation & Depth
Depth is not a shadow; it is a state of light.

*   **The Layering Principle:** To lift a project card, place a `surface_container_high` card onto a `surface_container_low` background. The slight shift in tonal blue creates a natural "lift" without visual clutter.
*   **Ambient Shadows:** For floating elements, use a "Glow Shadow" rather than a grey shadow. Use `surface_tint` at 8% opacity with a 40px blur. This mimics the light of the screen hitting the frosted glass.
*   **The "Ghost Border" Fallback:** If containment is needed for accessibility, use the `outline_variant` token at **15% opacity**. This creates a "frosted edge" rather than a hard line.
*   **Glassmorphism:** Every interactive panel should feel like a slice of polished sapphire. Combine `surface_container_lowest` at 60% opacity with a `primary` colored 1px inner-stroke at 10% opacity to catch "rim light."

### 5. Components

*   **Floating Glass Navbar:**
    *   **Base:** `surface_bright` at 30% opacity, 24px blur, `xl` (1.5rem) corner radius.
    *   **Active State:** No underline. Use a small `primary_fixed` dot (4px) below the label or a subtle glow behind the text.
*   **Neon-Glowing Icons:**
    *   Icons should use `primary_fixed` color. Apply a secondary "Outer Glow" layer using a Shadow with 12px blur of the same color at 30% opacity.
*   **Project Cards (The Flutter Showcase):**
    *   **Interaction:** On hover, use an `InkWell` scale-up (1.02x).
    *   **Background:** Seamless transition from `surface_container_low` to `surface_container_highest`.
    *   **Mockups:** Use high-fidelity phone frames. The screen content should bleed slightly outside the frame using a `stack` to emphasize the "breaking the grid" editorial style.
*   **Buttons:**
    *   **Primary:** Gradient fill (`primary_fixed` to `primary_container`). `md` (0.75rem) radius. Text color: `on_primary_fixed`.
    *   **Tertiary:** No fill. `primary_fixed` text with a subtle `primary` glow on hover.
*   **Chips:**
    *   Small `sm` (0.25rem) radius. Background: `surface_variant`. Border: Ghost Border (10% `outline`).

### 6. Do's and Don'ts

*   **DO:** Use asymmetrical padding. A project description might have more top-padding than bottom-padding to create a "scrolled" editorial feel.
*   **DO:** Use `tertiary_fixed_dim` (#4cd6ff) for secondary accents to keep the "electric" vibe consistent.
*   **DON'T:** Use divider lines. Use 64px or 80px of vertical whitespace (from your spacing scale) to separate thoughts.
*   **DON'T:** Use pure black (#000000). The deepest shadows should always be `surface_container_lowest` to maintain the navy/charcoal tonal depth.
*   **DO:** Ensure the "InkWell" scale effect has a duration of 200ms with a `Curves.easeOutCubic` for a snappy, high-end feel.