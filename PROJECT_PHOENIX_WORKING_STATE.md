# Project Phoenix — Living Project State

**Purpose:** durable cross-chat engineering state for Project Phoenix.
**Repository:** CGShepherd/Phoenix
**Host equipment:** two Quad 521F amplifiers
**Status vocabulary:** CLOSED / PROVISIONAL / OPEN / SUPERSEDED.
**Last reconciled:** 2026-10-03.

## 1. Use and chat protocol
Read this file first when starting/resuming Phoenix. It is the living state index, not a transcript. Specialist calculations, ADRs, verification records, schematics and test evidence remain authoritative. Do not silently overwrite controlled evidence.

Record material decisions contemporaneously. CLOSED means do not reopen without new evidence/changed requirement; PROVISIONAL means preferred direction with bounded evidence outstanding; OPEN means unresolved design-critical question; retain SUPERSEDED positions rather than erasing history. Git/GitHub is the intended durable configuration record; inspect diffs before commits and do not silently rewrite released baselines.

Every substantive Phoenix response shall end with **Confidence: NN%** plus the principal uncertainty, and **Chat capacity: approximately NN% remaining**. Capacity is an estimate of conversational/context headroom, not a measured product limit. Warn early as capacity becomes constrained. Handover prompts should be short because durable state lives here.

## 2. Engineering principles
1. Evidence before opinion; distinguish measurement, authoritative source, calculation and judgement.
2. Preserve proven Quad architecture unless change has measurable performance, reliability or safety justification.
3. Affordable performance: complexity and premium parts must earn their place.
4. Optimise the system: receiver, PSU, grounding, host amplifier, protection, mechanics and thermal behaviour interact.
5. Simplicity and serviceability are design objectives.
6. Design for the next engineer: readable documentation, test points, revisions and repairable construction.
7. Retain decisions, reopen criteria and superseded positions.
8. Use first principles/simulation where useful; close important assumptions by bench measurement.
9. Do not let PCB layout dictate host mechanics prematurely; 521F mechanical/thermal envelope constrains PCB geometry.
10. Thermal management is a reliability problem, not merely an absolute-temperature problem.
11. Maintain 521F channel/reference partitioning; do not casually join grounds, output returns or regulated-earth nodes.
12. Preserve the original-versus-upgraded 521F A/B opportunity where practical before modifying the second unit.

## 3. Current architecture
Per 521F: two independent channel zones. Each channel has one THAT1206 receiver at the original balanced-input-module position, one Architecture C auxiliary PSU/protection assembly, one HiFiSonix MOSFET speaker-protection board configured for mono use, and one nominally identical central carrier/thermal-spreader assembly. Across two 521Fs the immediate populated requirement is four channels; extra bare PCBs may be procured.

## 4. Balanced receiver
**CLOSED:** transformerless THAT1206; -6 dB nominal gain; dedicated Architecture C split rails; nominal +/-17 V final rails; no electrolytic intended in audio path; original balanced-module position retained.

**OPEN/PROVISIONAL:** RF/EMI/ESD; XLR pin-1/chassis; receiver 0 V versus Quad regulated earth/input reference; final output coupling/value; gain/sensitivity and attenuator calibration; connectors/test points/layout; required common-mode fault envelope.

## 5. Architecture C auxiliary PSU
**CLOSED architecture:** raw Quad rail -> dedicated branch fuse -> 100 ohm branch resistor -> filtered nominal 24 V Zener -> TIP41C/TIP42C emitter-follower preregulator -> LM317/LM337 -> nominal +/-17 V receiver rail. Protection includes SMBJ30A TVS, BZX55C30-triggered 2N5064 SCR crowbar and fuse-based sustained-energy removal.

Accepted family includes TIP41CG/TIP42CG, LM317AT/NOPB, LM337T/NOPB, BZX55C24/C30, 47 uF Zener filtering, 10 uF outputs, 100 ohm pulse/flameproof branch resistor and 62 mA very-fast fuse. Load basis: THAT1206 about 4.7 mA typical, 8 mA design, 10 mA stress unless superseded by measurement.

Electrical Architecture C is not reopened. Its mechanical/thermal implementation is reopened because preregulator dissipation and the sealed central 521F region require deliberate heat export.

## 6. Quad 521F host
Treat 521F as distinct from generic 520f: factory balanced input, regulated-earth/synthetic-0V architecture, four-terminal channel behaviour and floating speaker-output considerations matter.

One 521F has Dada/QuadSpot-derived upgrades. User additionally balances each current-dumping bridge individually using measured components and Quad equations. Second 521F is planned for equivalent work.

**CLOSED:** bridge optimisation is per-channel measurement/calculation, not copying nominal 909/other-channel values.

**OPEN:** resolve Dada D1/D2/D12 bypass-document discrepancy; review DC servo; characterise thermally stressed parts/PCB; close receiver grounding/gain interfaces.

## 7. Speaker protection
Selected hardware: HiFiSonix Speaker Protection Board using MOSFET solid-state switching, not relays.

**CLOSED:** one board per 521F channel; two per amplifier/four total; configure for mono use; mount on corresponding channel carrier; do not combine channel references to reduce board count.

**OPEN/PROVISIONAL:** exact mono BOM population (one switching path versus use/paralleling of both) pending current, RDS(on), dissipation, SOA and PCB-current analysis; exact 521F supply configuration; connectors/wiring; capture actual board dimensions, mounting pattern and populated height.

## 8. Mechanical and thermal architecture
**CLOSED principles:** mechanics/thermal integration is first-class; two channel-specific central carriers per 521F; each carries one Architecture C PSU and one mono HiFiSonix board; THAT1206 modules remain separately mounted; avoid unnecessary external holes; preserve serviceability; covers are thermal surfaces rather than PCB structural supports; establish mechanical envelope before PCB-outline freeze.

**PROVISIONAL thermal concept:** heat source -> aluminium carrier/spreader -> compliant thermal interface/contact land -> top and/or bottom steel cover -> ambient. Aluminium spreads heat; broad cover contact exports it from the sealed central region. Both covers are candidates. Compressible silicone gap pads are preferred conceptually to grease for removable covers/tolerance accommodation.

Carrier concept: folded aluminium sub-chassis with hotter Architecture C/thermal zone, cooler speaker-protection zone, service/interface zone, and formed thermal lands toward one/both covers. Protection board shares carrier but should not become Architecture C's heat path.

The previous purely structural/non-heatsink bracket assumption is **SUPERSEDED provisionally** by investigation of an integrated structural + thermal-spreader carrier. Final thermal role remains PROVISIONAL pending measurement.

**OPEN:** chassis/mounting/cover/loom survey; protection-board envelope; cover contact zones; realistic heat budget; protection MOSFET losses; 2-3 carrier concepts; top/bottom/dual-cover thermal-resistance comparison; live-tab isolation; mechanical prototype before PCB-outline freeze. Do not add fans/ventilation until data shows passive conduction inadequate.

## 9. Thermal characterisation
Before final carrier design, instrument a 521F and record temperature versus time at idle, defined moderate load and controlled higher-power operation, using an equilibrium criterion. Candidate points: transformer/central PSU, rectification, reservoir capacitors, regulated-earth devices, known hot resistors/semiconductors, channel heatsinks, central internal air and external covers. Use original versus Dada-upgraded amplifiers as an A/B opportunity. Design for reliability/electrolytic lifetime, not merely absolute maxima.

## 10. Pre-second-amplifier verification opportunity
Candidate A/B measurements: gain/sensitivity, frequency response, THD+N versus power/frequency, residual noise, DC offset/servo behaviour, transient response into defined loads, thermal behaviour, bridge residual/error where measurable, original balanced-input CMRR/behaviour.

## 11. Current critical path
1. Keep this living record current and preserve controlled repository state.
2. Capture HiFiSonix mono-BOM and mechanical details.
3. Complete 521F mechanical and thermal survey.
4. Close receiver/521F grounding, sensitivity/gain, RF/ESD, coupling, connectors/test points and common-mode requirement.
5. Quantify thermal load and develop carrier/spreader concepts.
6. Reconcile ADRs/decision register as evidence closes decisions.
7. KiCad receiver + Architecture C constrained by mechanical envelope.
8. Pin/polarity/authority verification.
9. PCB/layout and bench validation.
10. Final mechanical prototype/thermal validation before manufacturing release.

## 12. Reopen discipline
Do not reopen CLOSED decisions because an alternative is merely interesting. Reopen for new evidence, changed requirements, failed verification, availability/manufacturability problems or demonstrated material improvement. Historical drafts do not outrank later controlled decisions; reconcile conflicts explicitly.

## 13. Minimal next-chat handover
“Continue Project Phoenix. Read PROJECT_PHOENIX_WORKING_STATE.md in full first and treat it as the living project-state index. Then inspect specialist controlled files relevant to the immediate task. Do not regress to superseded decisions. Continue to report confidence and estimated chat capacity in every substantive Phoenix response.”
