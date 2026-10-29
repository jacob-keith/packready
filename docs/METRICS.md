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

