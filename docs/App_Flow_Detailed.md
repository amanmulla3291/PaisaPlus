Here's the **updated App Flow** for **PaisaPlus**, incorporating your requirement of **strictly "Continue with Google" only** for authentication.

The new flow adds a dedicated **4-screen onboarding experience** that occurs **before** the Google Sign-In screen. This design educates users about the app's value, builds excitement, highlights the privacy-first and Kite-level polish USP, and gently prepares them for the exclusive admin-approval model — all while keeping the flow lightweight, visual, and under 60–90 seconds.

### Updated Overall App Launch Flow

1. **Splash Screen** (brief animated logo with tagline "Private. Simple. Powerful Expense Tracking")
2. **4-Screen Onboarding Carousel** (first-time users only — swipeable, with progress dots and "Skip" / "Next" at bottom)
3. **Google Sign-In Screen** (clean, prominent red "Continue with Google" button — no other auth options)
4. **Post-Login Logic** (device binding check + Pending screen for normal users or direct Home for admins)
5. **First-Time Setup Wizard** (minimal post-approval steps)
6. **Main App** (Home Dashboard)

Returning users who are already approved and device-bound skip directly from Splash → Home (after silent auth refresh).

### Detailed 4-Screen Onboarding Flow (Before Login/Signup)

The onboarding uses a smooth horizontal carousel (PageView in Flutter) with large illustrations, bold Kite-style typography, minimal text, and Zerodha-red accents. Each screen has a "Next" button (progressive) and a subtle "Skip" in the top-right that jumps straight to Google Sign-In.

**Screen 1: Welcome & Value Proposition**  
- **Visual**: Bold illustration of a secure wallet/lock icon combined with growing money graph (dark theme friendly).  
- **Headline**: "Take control of your money — privately."  
- **Subheadline**: "PaisaPlus is a fully offline expense tracker with Kite-level polish. No data leaves your phone. No subscriptions. Ever."  
- **Key highlights** (3 small bullets with icons):  
  - 100% Local & Encrypted  
  - Beautiful dashboards & insights  
  - Free forever (all premium features unlocked)  
- **CTA**: Big red "Get Started" button (advances to next screen) + small "Skip" top-right.  
- **Purpose**: Instantly communicate the privacy USP and differentiate from cloud-heavy competitors like Walnut or ET Money.

**Screen 2: Simple & Fast Tracking**  
- **Visual**: Animated quick-add flow (FAB → calculator pad → category grid) or swipeable transaction example.  
- **Headline**: "Track expenses in seconds"  
- **Subheadline**: "Add income, expenses, or transfers with our Kite-inspired calculator. Smart categories for India — UPI, Fuel, Rent, Groceries & more."  
- **Features shown**: Quick FAB, swipe actions, recurring transactions, photo/notes attachment.  
- **CTA**: "Next" button.  
- **Purpose**: Show daily usability and speed — the core habit that competes with top apps.

**Screen 3: Smart Budgeting & Insights**  
- **Visual**: fl_chart-style pie + line chart mockup with progress bars (green/red indicators) and goal progress ring.  
- **Headline**: "Budget smarter. Understand deeper."  
- **Subheadline**: "Unlimited budgets, savings goals, loan trackers, and powerful offline reports. See where your money goes with beautiful visuals."  
- **Highlights**: Envelope budgeting option, monthly trends, insights like "You spent 18% less on dining this month".  
- **CTA**: "Next".  
- **Purpose**: Tease the "premium" features that are free here (unlike competitors) and build desire for analytics.

**Screen 4: Privacy, Security & Exclusive Access**  
- **Visual**: Shield/lock illustration + device icon + subtle admin badge.  
- **Headline**: "Your data. Your rules. Exclusive access."  
- **Subheadline**: "Fully encrypted local storage • Biometric lock • Monthly local backup • One device per account. Admin approval keeps it private and high-quality."  
- **Key points**:  
  - Sign in with Google → Wait for approval (quick for most users)  
  - Long-press logo for admin features (tease exclusivity)  
  - "Your financial data never touches any cloud"  
- **CTA**: Prominent red "Continue with Google" button (leads directly to Google Sign-In screen).  
- **Purpose**: Reinforce trust, explain the admin gate gently, and convert the user right at the moment of highest interest.

**Onboarding Mechanics**:
- Shown only on first launch (stored in local Isar or SharedPreferences).
- Smooth animations between screens (fade + slight parallax on illustrations).
- Progress indicators (4 dots at bottom).
- "Skip" always available but less prominent.
- Dark theme consistent with the rest of the app.
- All illustrations can be custom or use high-quality vector assets.

### Post-Onboarding → Google Sign-In Screen
- Clean minimal screen with app logo at top.
- Centered illustration or animation.
- Big red button: **"Continue with Google"** (uses `google_sign_in` package).
- Small footer text: "By continuing, you agree to our Privacy Policy" (links to local/privacy page — emphasize no data collection).
- No email/password or other options (as per your strict rule).

### What Happens After Google Sign-In (Unchanged from Previous Plan)
- Silent device fingerprint check.
- If admin → direct to Home.
- If normal user → Pending Approval screen (with nice illustration and "Waiting for admin approval..." message).
- Once approved → minimal First-Time Setup Wizard:
  - Confirm currency (INR default).
  - Quick account creation (Cash, Bank, UPI, Credit Card — pre-filled suggestions).
  - Enable biometric/PIN lock.
- Then land on **Home Dashboard**.

### Why This 4-Screen Onboarding Works Well
- **Educational**: Users understand the privacy edge and exclusive feel before committing.
- **Low Friction**: Visual-heavy, short text, swipeable — completion rate stays high.
- **Conversion-Focused**: Screen 4 ends with the Google button at peak motivation.
- **Consistent with Rules**: No data collected during onboarding. Everything local until Google Sign-In (which only gives identity + minimal profile).
- **Kite Polish**: Matches the fintech-grade feel — bold, red accents, smooth transitions.

This integrates seamlessly with the rest of the flows you already have:
- Bottom navigation (Home | Transactions | Budgets | Reports | More)
- Red FAB quick-add
- Local encrypted backup
- Admin long-press on logo (anywhere after login)
