# SentryKSA (Al-Man’aa) - Project Milestones & Timeline

This document tracks our progress from the initial Genesis concept to a fully deployable Minimum Viable Product (MVP) ready for institutional review and Saudi Arabian grant applications.

## Phase 1: Proof of Concept (PoC) & Architecture Scaffold
**Status:** ✅ COMPLETING NOW

We have successfully built the foundation to prove the math and the user interface.

*   [x] **Project Initialization:** Stand up Flutter cross-platform architecture.
*   [x] **Grant Materials:** Draft professional `README.md`, `REPO_DESCRIPTION.txt`, and `WHITEPAPER_OUTLINE.md`.
*   [x] **Genesis Logic Engine:** Implement `StrategicAsset` data models and `SentryIntelligenceEngineRefined` for dynamic economic math (GDP loss, Brent shock, supply chain index).
*   [x] **State Management:** Implement `ThreatProvider` for real-time imminent threat countdowns.
*   [x] **API Simulation:** Create `ApiService` to mock OSINT data coming from X, Telegram, and Instagram.
*   [x] **UI/Logic Wiring:** Connect the dashboard so tapping map assets generates real-time analytics based on the engine.
*   [x] **GIS Integration:** Inject Google Maps API key into Android, iOS, and Web configurations to render real satellite imagery.

---

## Phase 2: Building the "Brain" (Backend MVP)
**Status:** ⏳ NEXT UP

This phase replaces our simulated data with real-time, live intelligence gathering.

*   [ ] **Backend Initialization:** Stand up a Python / FastAPI microservice architecture.
*   [ ] **OSINT Scrapers:** Write Python scripts using `BeautifulSoup`, `Tweepy`, or `Telethon` to scrape X (Twitter) accounts (e.g., CENTCOM), Telegram channels, and global news RSS feeds.
*   [ ] **Basic NLP Engine:** Implement a simple Natural Language Processing script (e.g., using HuggingFace or OpenAI API) to scan scraped text for keywords ("ballistic", "drone", "Riyadh", "Aramco") and determine "Threat Validity".
*   [ ] **API Connection:** Refactor the Flutter `ApiService` to make live HTTP `GET` requests to our new Python backend instead of using mock delays.

---

## Phase 3: Data Expansion & Deployment (Full MVP)
**Status:** 🗓️ PLANNED

Scaling the system for real-world demonstration.

*   [ ] **The 500+ Asset Vault:** Replace the 3 hardcoded locations with a full database (JSON or PostgreSQL) containing the accurate GPS coordinates, output values, and repair tiers for KSA's energy, water, government, and data infrastructures.
*   [ ] **GPS Civilian Safety:** Implement geolocation tracking on the Flutter app to trigger local sirens/alerts if the user's phone is within 15km of an active target.
*   [ ] **Dual-Language Support (i18n):** Implement full Arabic (RTL) and English localization for the War Room dashboard and advisory panels.
*   [ ] **Cloud Hosting:** Deploy the FastAPI backend to AWS, Google Cloud, or a local secure KSA server.
*   [ ] **Security Hardening:** Ensure API routes are secured (JWT tokens), and API keys (like Google Maps) are moved into `.env` files for production safety.

---

## Phase 4: Institutional Review & Grant Submission
**Status:** 🗓️ PLANNED

*   [ ] **Whitepaper Finalization:** Expand the `WHITEPAPER_OUTLINE.md` with final data points from the MVP.
*   [ ] **Demo Video:** Record a video of the app running live OSINT data.
*   [ ] **Submission:** Submit to TAQADAM, NTDP, or relevant defense/tech incubators.
