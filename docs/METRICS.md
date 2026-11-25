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

# PackReady Analytics & Success Metrics Specification

The PackReady team will use the collected metrics to identify areas where the application can be improved and to determine whether users are having a positive experience. These metrics will guide future development decisions and let the team prioritize improvements based on user behavior rather than assumptions.

## 1. Onboarding Completion Tracking

When a user completes their profile and taps **Submit** on the final onboarding screen, FlutterFlow reports the event to Google Analytics (GA4).

**Submit button, On Tap action sequence**

1. Validate the form and save the profile to Firestore.
2. **Firebase Analytics → Log Event:** `onboarding_complete`
   - `profile_fields_completed` (int)
   - `method` (string: `email` | `google`)
3. **Firebase Analytics → Set User Properties:**
   - `signup_date` (ISO date)
   - `gender` (optional, see below)
4. Navigate to the home screen.

**Setup requirements**

- Enable Firebase Analytics in FlutterFlow (Settings → Integrations → Firebase) and link the Firebase project to a GA4 property.
- Register `onboarding_complete` and its custom parameters as custom definitions in GA4, or they will not appear in reports.

### Gender (optional user property)

- Collected only if the onboarding form asks for it. It is never inferred.
- The field is optional and includes a "Prefer not to say" choice. The property is set only when the user answers.
- Allowed values: `female`, `male`, `non_binary`, `undisclosed`.
- Sent as a **user property**, not an event parameter.
- The form must disclose that the answer is used for analytics and marketing, consistent with the privacy policy and consent banner. It is not sent if the user declines analytics.
- No other PII (name, email, free text) is sent to GA.

## 2. Metrics

### 2.1 User Retention
- **Problem trigger:** Fewer than X% of new users return within the first week.
- **Action:** Investigate whether the app provides enough value to encourage repeated use.
- **Events/properties:** `sign_up`, `onboarding_complete`, auto `session_start`, user property `signup_date`.
- **Measurement:** GA4 Retention report and a weekly signup cohort exploration.

### 2.2 Task Success Rate
- **Problem trigger:** Packing checklist completion rate is below X%.
- **Action:** Review the creation flow for confusing steps or usability issues.
- **Events:**
  - `checklist_started`
  - `checklist_step_viewed` (`step_name`)
  - `checklist_created` (`item_count`, `used_template`)
  - `checklist_abandoned` (`last_step`)
- **Measurement:** Funnel exploration from started to created. Abandonment rate is 1 minus completion rate. `last_step` shows where users drop off.

### 2.3 Click-Through Rate (Activity Templates)
- **Problem trigger:** Template CTR is below X%.
- **Action:** Improve the visibility, placement, or wording of templates.
- **Events:**
  - `template_impression` (`template_id`, `position`)
  - `template_selected` (`template_id`, `position`)
- **Measurement:** CTR = `template_selected` / `template_impression`, broken down by `position`.

### 2.4 User Satisfaction (NPS)
- **Problem trigger:** NPS is below X, or detractors exceed Y%.
- **Action:** Review user feedback to identify potential improvements.
- **Events:** `nps_submitted` (`score` 0-10, `segment` = `detractor` | `passive` | `promoter`).
- **Measurement:** NPS = % promoters (9-10) minus % detractors (0-6). Optional comments are stored in Firestore, not GA, and reviewed alongside low scores.

### 2.5 Adoption
- **Problem trigger:** More than X% of registered users never create a first packing list.
- **Action:** Evaluate the onboarding experience.
- **Events:** `sign_up`, `onboarding_complete`, `first_checklist_created` (fired once per user, guarded by a Firestore flag).
- **Measurement:** Funnel from `sign_up` to `onboarding_complete` to `first_checklist_created`, plus time between steps.

### 2.6 Time to Start Packing

- **HEART Category:** Task Success / Engagement
- **What it is:** How many seconds it takes from when someone opens their trip packing list to when they check off their first item.
- **Why we care:** The whole point of PackReady is helping people actually get started instead of putting off packing until the last minute. If someone generates a list, opens it, and closes the app without checking anything off, the list probably felt like too much work to deal with. If the time to that first check-off is low, it means people are opening the list and immediately finding something easy to grab and pack.
- **How we'll track it (Firebase Analytics):** Save a timestamp when the packing list page opens. The first time the user checks an item off during that visit, log a `first_item_packed` event to Firebase with `seconds_to_first_check` (current time minus open time) and `total_items` on the list. (Not wired up in the app yet.)
- **Goal:** Median under 30 seconds from opening the list to checking off the first item.

## 3. Implementation Notes

- Use snake_case event names under 40 characters, with 25 or fewer parameters per event.
- FlutterFlow has no built-in "page left" event. Log `checklist_abandoned` from back/cancel actions. For app-close cases, use a custom action with `WidgetsBindingObserver`, or treat `checklist_started` with no `checklist_created` after 30 minutes as abandoned.
- Review the dashboard weekly. When a trigger fires, record the investigation and the resulting change so improvements can be tied back to the data.
- Never send PII (names, emails, free-text comments) in events or user properties.

## Metrics Evaluation and Improvement

The PackReady team will use the collected metrics to identify areas where the application can be improved and determine whether users are having a positive experience.

- **Low User Retention:** If users are not returning within' the first week, we will investigate whether the app provides enough value to encourage repeated use.
- **Low Task Success Rate:** If users frequently abandon packing checklist creation, we will review the process to identify confusing steps or usability issues.
- **Low Click-Through Rate:** If users utilize activity templates, we will consider improving its visibility, placement, or wording.
- **Low User Satisfaction:** If Net Promoter Score (NPS) responses indicate dissatisfaction, we will review user feedback to identify potential improvements.
- **Low Adoption:** If new users register but do not create their first packing list, we will evaluate the onboarding experience.

These metrics will help guide future development decisions and allow the team to prioritize improvements based on user behavior rather than assumptions.






