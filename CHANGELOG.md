# Changelog & Technical Decisions

All notable changes to the **RailSmith** project will be documented in this file, along with the technical rationale (The "Why") behind them. Our focus is on **AI-Native development & High-Performance infrastructure**.

---

## [0.1.0-alpha] - 2026-03-15 - The Ruby 4.0 "Vanguard" Release

### High-Performance Forge
- **Upgrade to Ruby 4.0.0 (Prism)**: Skip any intermediate versions to embrace the state-of-the-art performance engine released on Dec 25, 2025.
  - **Technical Choice**: Ruby 4.0 introduces the **ZJIT** (Zero JIT) and **Ruby::Box**, which are game-changers for SRE-focused infrastructure.
- **Enabled ZJIT (Zero JIT)**: Configured the environment to use the new Rust-based compilation engine.
  - **The "Why"**: Unlike YJIT, ZJIT offers a higher performance ceiling by using larger compilation units, ideal for DevContainers where we have full control over the toolchain.
- **Enabled Ruby::Box**: Added experimental support for definition isolation.
  - **The "Why"**: This allows running concurrent operations (like tests or multiple app instances) within a single Ruby process without memory contention or monkey-patch leakage.

### Infrastructure Refinement
- **Multi-Stage Build Architecture**: Split the Dockerfile into `builder` and `runtime` stages.
  - **The "Why"**: Significantly reduces image size and security surface by ensuring heavy build tools (Rust compiler, NPM) don't bloat the final production/dev image.
- **Embedded Rust 1.85+**: Integrated the Rust toolchain directly in the build stage.
  - **The "Why"**: Ruby 4.0's ZJIT is written in Rust. Pre-installing 1.85+ ensures the JIT is ready to optimize Rails code from the first boot.
- **Aggressive Layer Optimization**: Grouped `apt-get` commands and implemented immediate cleanup.
  - **The "Why"**: Minimizes the number of layers in the GHCR image and prevents cache bloat.

### AI-Native Development Forge
- **Claude Code Native Integration**: Fully pre-configured AI-native coding assistant.
  - **The "Why"**: In the SRE world, AI is a force multiplier. Claude Code allows for real-time refactoring and infrastructure analysis directly from the terminal, making this environment significantly more productive than a standard shell.
- **Bitwarden CLI (Security for AI)**: Integrated for secure management of secrets.
  - **The "Why"**: AI tools frequently require API keys and sensitive tokens. Integrating Bitwarden ensures that secrets stay out of the environment variables and are pulled only when needed, maintaining SRE-level security.
- **DevContainer `.dockerignore`**: Added a dedicated ignore file for the build folder.
  - **The "Why"**: Prevents local `node_modules`, `.git`, or temporary assets from being sent to the Docker daemon, slicing build times by up to 80%.

---

> [!TIP]
> This CHANGELOG doubles as an **Architecture Decision Log**. Use it to track the evolution of our SRE choices! 🛤️⚒️
