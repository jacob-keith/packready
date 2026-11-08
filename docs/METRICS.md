# PackReady Metrics

## Google HEART Framework
[View PackReady HEART Framework](https://docs.google.com/presentation/d/19aBMbP3snPf5Pp2lY18R0ipb3aSj3BjL0fVVajp3eE0/edit?usp=sharing)

## Metrics and Data Collection

- **Net Promoter Score (NPS):**
  Ask users how likely they are to recommend PackReady on a scale of 0–10. Store survey responses in Firebase Firestore.

- **Adoption:**
  Track new user registrations using Firebase Authentication. Measure how many new users complete profile setup and create their first packing list.

- **Daily Active Users (DAU):**
  Use Firebase Analytics to measure the number of unique users actively using PackReady each day.

- **Retention:**
  Use Firebase Analytics to track how many users return after 1, 7, and 30 days.

- **Click-Through Rate (CTR):**
  Track how often users click the "Generate Checklist" button compared with how many users view the checklist creation page. Record button clicks using a Firebase Analytics custom event.

- **Average Packing Lists Created:**
  Count packing lists stored in Firebase Firestore and divide by the number of active users over the same period.

- **Task Success Rate:**
  Measure how many users successfully generate and complete their packing checklists using Firestore checklist data.

Note: Metrics that are not already tracked will require additional Firebase Analytics events or Firestore data collection.


Onboarding Completion -- whenever a user creates a full profile and clicks submit after the onboarding screen have flutterflow report that to google analytics and also provide them their gender for extra marketing purposes

## Metrics Evaluation and Improvement

The PackReady team will use the collected metrics to identify areas where the application can be improved and determine whether users are having a positive experience.

- **Low User Retention:** If users are not returning within' the first week, we will investigate whether the app provides enough value to encourage repeated use.
- **Low Task Success Rate:** If users frequently abandon packing checklist creation, we will review the process to identify confusing steps or usability issues.
- **Low Click-Through Rate:** If users utilize activity templates, we will consider improving its visibility, placement, or wording.
- **Low User Satisfaction:** If Net Promoter Score (NPS) responses indicate dissatisfaction, we will review user feedback to identify potential improvements.
- **Low Adoption:** If new users register but do not create their first packing list, we will evaluate the onboarding experience.

These metrics will help guide future development decisions and allow the team to prioritize improvements based on user behavior rather than assumptions.






