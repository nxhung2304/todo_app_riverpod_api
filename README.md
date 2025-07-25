# 📌 Todo App API – Roadmap & Endpoint Design

## 🧭 Feature Roadmap

### 1. Authentication (using devise / devise_token_auth / googleauth)
- [x] `POST /auth` – Register
- [x] `POST /auth/sign_in` – Login
- [x] `DELETE /auth/sign_out` – Logout
- [x] `GET /auth/validate_token` – Session check
- [x] POST /auth/google_login - Verify Google Token

### 2. Task Management
- [ ] `GET /todos` – List all todos
- [ ] `POST /todos` – Create new task
- [ ] `GET /todos/:id` – Show task
- [ ] `PUT /todos/:id` – Update task
- [ ] `DELETE /todos/:id` – Delete task
- [ ] `PATCH /todos/:id/toggle` – Toggle task status (done/undone)

### 3. Task Attributes (Extensions)
- [ ] `due_date` – Deadline support
- [ ] `description` – Long text support
- [ ] `priority` – Task priority (integer)
- [ ] `color` – Tag color for UI
- [ ] `position` – Support drag & reorder
- [ ] `attachments` – Optional file uploads
- [ ] `reminders` – Push/email reminder (cronjob or background job)

### 4. Task Filtering / Querying
- [ ] `/todos?done=true` – Filter by done
- [ ] `/todos?due=today` – Filter by due date
- [ ] `/todos?list_id=1` – Filter by list
- [ ] `/todos/search?q=keyword` – Keyword search

### 5. Todo List (Grouping)
- [ ] CRUD endpoints for `/todo_lists`
- [ ] Assign task to list
- [ ] Group todos by list for frontend

### 6. User Profile
- [ ] `GET /me` – Current user info
- [ ] `PUT /me` – Update profile
- [ ] Upload avatar (ActiveStorage or similar)

### 7. API Documentation
- [ ] Install `rswag` for OpenAPI spec
- [ ] Setup Swagger UI at `/api-docs`
- [ ] Generate specs for endpoints

---

## 📁 Suggested Project Structure

```
app/
├── controllers/
│ └── api/
│ ├── v1/
│ │ ├── tasks_controller.rb
│ │ ├── todo_lists_controller.rb
│ │ └── auth/
│ └── base_controller.rb
├── models/
│ ├── task.rb
│ ├── todo_list.rb
│ └── user.rb
└── serializers/
├── task_serializer.rb
└── todo_list_serializer.rb
```


---

## 📚 Future Enhancements

| Feature                   | Endpoint                             | Method |
|---------------------------|---------------------------------------|--------|
| Toggle task done status   | `/todos/:id/toggle`                  | PATCH  |
| Today's todos             | `/todos/today`                       | GET    |
| Upcoming todos            | `/todos/upcoming`                    | GET    |
| Search todos              | `/todos/search?q=...`                | GET    |
| Upload attachments        | `/todos/:id/attachments`             | POST   |

---

## 🔧 Suggested Gems
- `devise_token_auth` – Token-based user auth
- `active_model_serializers` – JSON formatting
- `rswag` – API documentation with Swagger/OpenAPI
- `ransack` or manual scopes – Filtering and search
- `sidekiq` – Background jobs (reminders, etc.)

---

## 🚧 Dev Setup TODO
- [ ] Protect endpoints with token
- [ ] Add RSpec & FactoryBot for testing
- [ ] Add seed data for dev
- [ ] Docker setup (optional)

