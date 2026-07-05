## Screenshots

| Home | Test |
|------|------|
| <img src="https://github.com/user-attachments/assets/49c21d2c-9703-4c43-8e9c-b98696a5e879" width="220"/> | <img src="https://github.com/user-attachments/assets/a514a6dd-c1d3-4fbe-a0e2-7fa1c8472ee0" width="220"/> |

---

## Approach

I interpreted the assignment as a **content-driven wellness dashboard** centered around three experiences:

- A weekly emotional check-in.
- Personalized guides based on the user's current mood.
- A lightweight "pick up where you left off" reading flow.

To keep the implementation simple and scalable, the home experience is driven by a **single `UserBloc`**.

### Responsibilities of `UserBloc`
- Load the user profile.
- Fetch pending, weekly, and mood-based guides.
- Handle check-ins and mood updates.
- Manage connectivity and offline state.

### Data Layer
The data layer is split into repositories:

- **`UserRepository`** – user profile and check-in updates.
- **`GuideRepository`** – guide retrieval and filtering.

### Architecture

```text
User action → Bloc → Repository → Firestore → State → UI rebuild
```

This separation keeps the UI declarative, centralizes business logic inside the bloc, and isolates Firestore interactions from the presentation layer.
