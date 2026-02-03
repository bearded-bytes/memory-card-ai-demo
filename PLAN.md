# Implementation Plan: Theme Selection Feature

## Issue Reference
GitHub Issue #1: Add theme selection
- **Description**: Create theme selector for different match emoji pairs such as animals, emoji, vehicles, and flags.

## Current State Analysis
- The game currently uses a hardcoded array of space-themed emojis (`['🚀', '🛸', '⭐', '🌙', '🪐', '☄️', '🌟', '🌌']`)
- The emoji array is defined in `src/App.jsx:12`
- The game initializes by duplicating and shuffling these emojis

## Proposed Solution

### 1. Theme Data Structure
Create a themes object with multiple emoji sets:
- **Space** (current): 🚀, 🛸, ⭐, 🌙, 🪐, ☄️, 🌟, 🌌
- **Animals**: 🐶, 🐱, 🐭, 🐹, 🐰, 🦊, 🐻, 🐼
- **Vehicles**: 🚗, 🚕, 🚙, 🚌, 🚎, 🏎️, 🚓, 🚑
- **Flags**: 🇺🇸, 🇬🇧, 🇨🇦, 🇩🇪, 🇫🇷, 🇮🇹, 🇪🇸, 🇯🇵

### 2. State Management
Add new state variables:
- `selectedTheme`: Track the currently selected theme (default: 'space')
- Store available themes in a constant object

### 3. UI Components

#### Theme Selector Screen (Before Game Start)
When `gameStarted` is false:
- Display theme selection buttons
- Each button shows the theme name and a sample emoji
- Visual feedback on hover
- Selected theme is highlighted

#### Update Start Game Flow
- User selects theme → clicks "Start Game" button
- The `initializeGame` function uses the selected theme's emojis

### 4. Implementation Steps

1. **Define themes constant** (above component)
   - Object with theme names as keys
   - Each theme has: name, emojis array, preview emoji

2. **Add state for theme selection**
   - `useState` for `selectedTheme`

3. **Update cardSymbols logic**
   - Change from constant to derived from selected theme
   - Use `themes[selectedTheme].emojis`

4. **Create theme selector UI**
   - Display before game starts
   - Grid of theme buttons
   - Show theme name and preview
   - Highlight selected theme

5. **Update initializeGame function**
   - Use current selected theme's emojis

6. **Add theme change during game** (optional enhancement)
   - Allow theme switching which resets the game

## Files to Modify
- `src/App.jsx` - Main component with all game logic

## Testing Checklist
- [ ] Theme selector displays correctly before game starts
- [ ] All 4 themes work properly when selected
- [ ] Game initializes with correct emojis for each theme
- [ ] Theme selection is responsive and has good UX
- [ ] Reset game maintains the selected theme
- [ ] Win modal works correctly for all themes

## Acceptance Criteria (from Issue #1)
✓ Create theme selector for different match emoji pairs
✓ Support at least 4 themes: animals, emoji (space), vehicles, and flags
✓ User can select theme before starting the game
✓ All cards update to match selected theme

## Technical Considerations
- Maintain existing game logic unchanged
- Ensure emoji arrays are exactly 8 items each for consistent gameplay
- Keep the existing UI/UX style and animations
- No breaking changes to game mechanics
