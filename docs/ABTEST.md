# PackReady A/B Test Design

## A/B Test Name: Large Button vs. Bottom Navigation Bar

**User Story Number:** [Add the user story number for creating activity templates or accessing packing lists]

### Metrics
- **Engagement:** Click-through rate (CTR) for creating activity templates.
- **Task Success:** Percentage of users who successfully create an activity template.
- **Happiness:** User satisfaction with the navigation design.
- **Retention:** Percentage of users who return to PackReady after 7 days.

### Hypothesis

Currently, PackReady uses one large "Create activity template" button on the main screen. Users must use this button to start creating a new activity template, while other options like Edit Profile and Logout appear separately.

We want to find out whether this simple button design or a bottom navigation bar is easier for users.

We believe adding a bottom navigation bar with Home, Create, and Profile will make the app easier to navigate and help users access important features faster.

### Experiment

We will use Firebase A/B Testing and Firebase Remote Config to compare two navigation designs.

- 50% of eligible users will see Version A, the current large button design.
- 50% of eligible users will see Version B, the bottom navigation bar design.
- Firebase Remote Config will control which navigation design users see.
- Firebase Analytics will track button clicks, template creation, and user engagement.
- We will record custom events such as `home_view`, `create_entry_tap`, and `template_created`.
- The main success metric will be the percentage of users who successfully create a template.
- We will also compare navigation click-through rates and user retention.
- The experiment will run for at least two weeks, with enough users needed for meaningful results.

### Variations

**Version A: Large Button (Current Design)**

- The main screen has one large "Create activity template" button.
- Edit Profile and Logout appear as separate options.
- Users click the large button to begin creating a packing template.

**Version B: Bottom Navigation Bar (New Design)**

- The main screen includes a bottom navigation bar.
- The navigation bar contains Home, Create, and Profile.
- Users select Create from the bottom bar to begin creating a packing template.
- Users can access their profile directly from the navigation bar.

Both versions will provide the same main features and use the same colors. The main difference will be the navigation design.

### Simple Design Comparison

| Version A: Current Design | Version B: New Design |
|---|---|
| PackReady Home | PackReady Home |
| Recent Activities | Recent Activities |
| Past Activities | Past Activities |
| **[ Create activity template ]** | |
| Edit Profile | |
| Logout | |
| | **[ Home / Create / Profile ]** |

### Expected Result

We expect Version B, the bottom navigation bar, to help users navigate PackReady more easily and increase engagement.

However, Version A may perform better because its large button is simple and easy to notice.

We will use Firebase Analytics results to determine which design helps more users successfully create packing templates.

## A/B Test Name: Standard Colors vs. High-Contrast Colors in Light and Dark Mode

**User Story Number:** [Add the user story number related to app appearance or user interface]

### Metrics
- **Happiness:** User satisfaction with the app's colors and appearance.
- **Engagement:** Click-through rate (CTR) for buttons and activities.
- **Task Success:** Percentage of users who successfully create packing templates.
- **Retention:** Percentage of users who return to PackReady after 7 days.

### Hypothesis

Currently, PackReady supports light mode and dark mode with different background, text, and button colors.

Some users may find certain buttons, text, and selected activities difficult to see because the colors do not stand out enough, especially in dark mode.

We want to find out whether the current color design or a higher-contrast color design makes PackReady easier to read and use.

We believe improving the color contrast in both light and dark modes will make buttons easier to recognize, improve readability, and help users complete their packing activities more easily.

### Experiment

We will use Firebase A/B Testing and Firebase Remote Config to compare two color designs.

- 50% of eligible users will see Version A, the current PackReady color design.
- 50% of eligible users will see Version B, the improved high-contrast color design.
- Both versions will support light mode and dark mode.
- Firebase Remote Config will determine which color palette users receive.
- Firebase Analytics will track button clicks, activity selections, and successfully created packing templates.
- Custom events such as `activity_selected`, `create_entry_tap`, and `template_created` will be recorded.
- We will collect user satisfaction ratings through a short in-app survey and store responses in Firebase.
- We will compare results separately for light-mode and dark-mode users.
- The experiment will run for at least two weeks, provided enough users participate.

### Variations

**Version A: Standard Color Design (Current Design)**

- Uses PackReady's existing light and dark mode colors.
- Light mode uses light backgrounds with dark text.
- Dark mode uses dark backgrounds with lighter text.
- Buttons and selected activities use the current highlight colors.
- Users can switch between light mode and dark mode.

**Version B: High-Contrast Color Design (New Design)**

- Uses stronger contrast between text and backgrounds.
- Buttons have more noticeable colors.
- Selected activities use a clearer green highlight.
- Light mode uses darker text and more visible button colors.
- Dark mode uses brighter text and clearer button highlights.
- Users can still switch between light mode and dark mode.

Both versions will have the same layout, navigation, buttons, and features. Only the color palette will change.

### Simple Design Comparison

| Version A: Standard Colors | Version B: High-Contrast Colors |
|---|---|
| Current light background | Light background with stronger text contrast |
| Current dark background | Dark background with brighter readable text |
| Existing button colors | More visible button colors |
| Current activity highlights | Clear green activity highlights |
| Existing text contrast | Improved text contrast |

### Expected Result

We expect Version B, the high-contrast color design, to improve readability and make PackReady easier to use in both light and dark modes.

Users may find it easier to identify selected activities, locate important buttons, and create packing templates.

However, some users may prefer the softer colors of Version A.

We will compare Firebase Analytics data and user satisfaction ratings to determine which color design provides a better user experience.
