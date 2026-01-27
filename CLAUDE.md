# CLAUDE.md - AI Assistant Guide

This document provides guidance for AI assistants working with the **DUMBO_presences_aquatiques_rares** repository.

## Project Overview

**Name:** Dispersed Volume / Abyss Musee Maquette
**Author:** AbW444 (arata.johann@gmail.com)
**Type:** Interactive 3D volumetric particle visualization web application
**Purpose:** Converts video footage into dispersed particle clouds using luminance-based depth mapping

### What This Project Does

This is a creative coding project that transforms 2D video into volumetric 3D particle systems:
- Real-time video-to-particle conversion using luminance for depth
- Interactive WebGL visualization with Three.js
- Multiple rendering modes (2D sprites, 3D geometries)
- Sophisticated animation system with breathing and flow effects

## Repository Structure

```
DUMBO_presences_aquatiques_rares/
├── README.md                              # Project title only
├── CLAUDE.md                              # This file
├── dispersed-volume_v1.3.1 (4).html       # Main application (single-file)
├── img/
│   └── presences_rares_favicon.png        # Favicon (234x234 PNG)
└── videos/
    ├── test_01.mp4                        # Test video assets
    ├── test_02.mp4
    ├── test_03.mp4
    └── test_04.mp4
```

## Technology Stack

| Component | Technology |
|-----------|-----------|
| 3D Rendering | Three.js (WebGL) |
| Frontend | Vanilla JavaScript (ES6+) |
| Markup | HTML5 |
| Styling | CSS3 (Flexbox, backdrop-filter) |
| Video Processing | Canvas 2D Context |
| Build System | None (single-file application) |
| Testing | None |
| Package Manager | None |

### External Dependencies

- **three.min.js** - Required but not included in repo (loaded via `<script>` tag)
- No npm packages or build tools

## Architecture

### Single-File Application

The entire application is contained in `dispersed-volume_v1.3.1 (4).html`:

1. **CSS Styles** (lines 7-198): Dark theme with glassmorphism UI
2. **HTML Markup** (lines 200-433): Controls, sliders, video preview
3. **JavaScript** (lines 435+): Three.js rendering and interactions

### Core Components

| Component | Description |
|-----------|-------------|
| `init()` | Initializes Three.js scene, camera, renderer |
| `generate()` | Creates particle system from video frames |
| `animate()` | RequestAnimationFrame render loop |
| `updateColorsFromVideo()` | Real-time video frame sampling |

### Key Global Variables

```javascript
let scene, camera, renderer, particles;   // Three.js objects
let currentVideo = null;                   // Video element
let currentShape = 'circle';               // Particle shape
let is3DMode = false;                      // 2D/3D toggle
let breathSpeed, flowIntensity;            // Animation params
let pointSize, particleDensity;            // Rendering params
let contrast, saturation, brightness;       // Color processing
```

## Code Conventions

### Naming

- **Variables/Functions:** camelCase (`currentVideo`, `depthMultiplier`, `updateColorsFromVideo`)
- **Data Attributes:** snake_case with hyphens (`data-shape`, `data-param`, `data-dir`)
- **CSS Classes:** lowercase with hyphens (`.param-row`, `.shape-btn`, `.slider-wrapper`)
- **Constants:** UPPERCASE (`TARGET_SIZE = 1000`)

### File Naming

- Version suffix pattern: `_v1.3.1`
- Test assets: sequential numbering (`test_01.mp4`, `test_02.mp4`)

### Code Organization Pattern

1. Global state variables (top)
2. Utility functions
3. Core logic functions
4. Event listener setup
5. Animation loop (bottom)

## Version History

| Version | Codename | Features |
|---------|----------|----------|
| v1.0 | Image dispersee | Static image to particles |
| v1.3 | Video dispersee | Video to particles |
| v1.3.1 | Luminance depth | Advanced depth + color processing |

## Configuration Parameters

### Visual Parameters (with defaults)

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| Point Size | 0.1-2.0 | 1.0 | Particle size multiplier |
| Particle Density | 1-15x | 7x | Sampling density |
| Depth Spread | 0.1-3.0x | 0.5x | Z-depth range |
| Breath Speed | 0-3.0 | 1.0 | Breathing animation speed |
| Brightness | 0.5-3.0 | 1.8 | Color brightness boost |
| Flow | 0-3.0 | 0.0 | Organic movement intensity |
| Black Threshold | 0-128 | 30 | Black color filter threshold |
| Depth Cull Power | 0.0-1.0 | 0.40 | Back-particle visibility |
| Contrast | 0.0-3.0 | 1.8 | Color contrast adjustment |
| Saturation | 0.0-2.0 | 1.10 | Color saturation adjustment |
| Background Threshold | 0-128 | 40 | Background removal threshold |

### Particle Shapes

- **2D Mode:** circle, square, diamond, star (texture sprites)
- **3D Mode:** box, sphere, octahedron, tetrahedron (InstancedMesh)

## Development Guidelines

### When Modifying This Project

1. **Single File:** All changes go in the main HTML file
2. **No Build Step:** Changes are immediate, just refresh browser
3. **Test with Videos:** Use provided test videos in `/videos/`
4. **Browser Console:** Use for debugging Three.js issues

### Performance Considerations

- Particle count depends on density (1-15x multiplier)
- High density + large videos can impact performance
- Use `DynamicDrawUsage` for InstancedMesh updates
- 150ms debounce on parameter changes

### Common Tasks

**Adding a new parameter:**
1. Add global variable
2. Add to `paramConfigs` object
3. Add HTML slider in `#controls`
4. Update `applySettings()` and `resetToDefaults()`
5. Use in `generate()` or `animate()` as needed

**Adding a new shape:**
1. Add button in `#shape-selector`
2. Add texture function (e.g., `createStarTexture()`)
3. Add geometry case for 3D mode
4. Update shape switching logic

### Browser Requirements

- WebGL support (required)
- ES6+ JavaScript
- HTML5 Video element
- File API for video loading

## Key Technical Details

### Luminance-Based Depth (v1.3.1)

```javascript
// Pixel luminance calculation
luminance = (r + g + b) / (3 * 255);

// Depth mapping
depth = (luminance - 0.5) * depthSpread;
```

### Video Sampling

- Fixed 1000x1000 sampling resolution
- Step-based sampling (1-10 pixels based on density)
- Off-screen canvas for pixel extraction

### Animation System

- Breathing: Subtle Z-axis oscillation
- Flow: Per-particle circular motion with random phase/speed/radius
- Both layered on base particle positions

## Git Workflow

- **Main Branch:** Development happens on feature branches
- **Commits:** Iterative uploads, directory reorganization
- **No CI/CD:** Manual testing only

## Testing

No automated tests. Manual testing workflow:
1. Open HTML file in browser
2. Load test video from `/videos/`
3. Adjust parameters
4. Verify visual output

## Quick Reference

### File Locations

| Need to... | Look in... |
|------------|-----------|
| Change UI styling | CSS section (lines 7-198) |
| Modify controls | HTML section (lines 200-433) |
| Update rendering | JavaScript `generate()` |
| Change animations | JavaScript `animate()` |
| Add parameters | `paramConfigs` object |

### Useful Functions

- `generate(video)` - Recreate particle system
- `applySettings()` - Apply current slider values
- `resetToDefaults()` - Reset all parameters
- `resetCamera()` - Reset camera position/rotation
- `scheduleRegenerate()` - Debounced regeneration

## Notes for AI Assistants

1. **This is a creative/artistic project** - visual quality matters more than code perfection
2. **Single-file architecture is intentional** - do not split into multiple files
3. **No build system needed** - keep it simple for direct browser loading
4. **Three.js is external** - the library is loaded via script tag, not bundled
5. **Test videos are large** - don't include in code changes, they're assets only
6. **Version naming matters** - follow the `_v1.X.X` pattern for new versions
