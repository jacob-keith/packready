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
