TaskHub API Documentation
Welcome to the TaskHub API documentation, a RESTful API for managing users and tasks.

Authentication
The API uses JSON Web Tokens (JWT) to secure its endpoints. To access protected routes, you must first obtain an access token and then send it in all subsequent requests within the Authorization header.

Header Format: Authorization: Bearer <your_token_here>

Authentication Flow
Send your credentials to the POST /Login route to receive an accessToken and a refreshToken.

The accessToken has a short expiration time and must be used to authenticate requests to protected routes.

When the accessToken expires, use the refreshToken (which has a long expiration time) on the GET /refrash-token route to obtain a new pair of tokens without needing to log in again.

Authentication Endpoints
1. User Login
Authenticates a user and returns the access tokens.

Method: POST

Route: /Login

Authorization: None required

Request Body: application/json

JSON

{
  "email": "your_email@example.com",
  "name": "USER NAME",
  "password": "your_password"
}
Success Response (200 OK):

JSON

{
  "accessToken": "ey...",
  "refreshToken": "ey..."
}
Error Response (401 Unauthorized):

JSON

{
  "error": "user does not exist or is not authorized, check the information."
}
2. Refresh Access Token
Generates a new accessToken and refreshToken from a valid refreshToken.

Method: GET

Route: /refrash-token

Authorization: Required (Bearer Token)

Success Response (200 OK):

JSON

{
  "accessToken": "new_ey...",
  "refreshToken": "new_ey..."
}
Global Parameters for Listings
The listing routes (GET /Usuarios and GET /Tarefas) support query parameters for filtering, sorting, and paginating the results.

Pagination
limit: Sets the maximum number of records per page. (Default: 10)

offset: Sets the starting record for the search. (Default: 0)

Example: GET /Tarefas?limit=5&offset=10 - Returns 5 tasks starting from the 11th record.

Sorting
sort: Defines the order of the results.

Format: field1,direction;field2,direction

direction can be asc (ascending) or desc (descending).

Example: GET /Usuarios?sort=nome,asc;criado_em,desc - Sorts users by name in ascending order, then by creation date in descending order.

Filtering
You can filter the results by passing the field name as a query parameter. The filter uses a partial search (LIKE '%value%').

Available Filter Fields:

For Users (GET /Usuarios): id, nome, email, Status

For Tasks (GET /Tarefas): id, titulo, descricao, StatusTarefa, usuario_id, nome (of the user), email (of the user), StatusUsuario

Example: GET /Tarefas?titulo=Report&StatusTarefa=PENDING - Returns tasks containing "Report" in the title with a status of "PENDING".

Users Endpoints
All /Usuarios routes are protected and require authentication.

1. List Users
Method: GET

Route: /Usuarios

Parameters: Supports Global Parameters.

Success Response (200 OK):

2. Get User by ID
Method: GET

Route: /Usuarios/:id

Success Response (200 OK):

3. Create New User
Method: POST

Route: /Usuarios

Request Body: application/json

Success Response (201 Created): Returns the newly created user object.

4. Update User
Method: PUT

Route: /Usuarios/:id

Request Body: application/json - Send only the fields you want to update.

Success Response (204 No Content): No body in the response.

5. Delete User
Method: DELETE

Route: /Usuarios/:id

Success Response (204 No Content): No body in the response.

Tasks Endpoints
All /Tarefas routes are protected and require authentication.

1. List Tasks
Method: GET

Route: /Tarefas

Parameters: Supports .

Success Response (200 OK):

2. Get Task by ID
Method: GET

Route: /Tarefas/:id

Success Response (200 OK): Returns the task object.

3. Create New Task
Method: POST

Route: /Tarefas

Request Body: application/json

Success Response (201 Created): Returns the newly created task object.

4. Update Task
Method: PUT

Route: /Tarefas/:id

Request Body: application/json - Send only the fields you want to update.

Success Response (204 No Content): No body in the response.

5. Delete Task
Method: DELETE

Route: /Tarefas/:id

Success Response (204 No Content): No body in the response.
