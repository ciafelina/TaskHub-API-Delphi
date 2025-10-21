# 🏗️ TaskHub API Delphi

![GitHub stars](https://img.shields.io/github/stars/ciafelina/TaskHub-API-Delphi?style=social)  
![License](https://img.shields.io/github/license/ciafelina/TaskHub-API-Delphi)  

> Uma API RESTful para gerenciamento de tarefas, construída com Horse e Delphi.

---

## ✨ Funcionalidades principais

- ✅ Autenticação via JSON Web Token (JWT)  
- 🔒 Rotas protegidas para usuários e tarefas  
- 📋 Listagem paginada, ordenação e filtragem de dados  
- 🛠️ Operações CRUD completas para usuários e tarefas  

---

## 📁 Estrutura do projeto


---

## 🚀 Como iniciar

### Pré-requisitos

- Delphi (versão compatível)  
- Componentes exigidos instalados (Horse, FireDAC, etc)  
- Banco de dados configurado conforme seu ambiente  

### Passos

```bash
# Clone o repositório
git clone https://github.com/ciafelina/TaskHub-API-Delphi.git
cd TaskHub-API-Delphi

# Abra o projeto no Delphi
# Compile e execute o projeto `main.dpr`

---

## 🚀 Como iniciar

### Pré-requisitos

- Delphi (versão compatível)  
- Componentes exigidos instalados (Horse, FireDAC, etc)  
- Banco de dados configurado conforme seu ambiente  

### Passos

```bash
# Clone o repositório
git clone https://github.com/ciafelina/TaskHub-API-Delphi.git
cd TaskHub-API-Delphi

# Abra o projeto no Delphi
# Compile e execute o projeto `main.dpr`
🧰 Uso da API
Autenticação

Para acessar rotas protegidas, você precisa obter um token:

Login
POST /Login
Corpo JSON:
{
  "email": "seu_email@exemplo.com",
  "name": "Nome do Usuário",
  "password": "sua_senha"
}
Retorno (200 OK):
{
  "accessToken": "ey...",
  "refreshToken": "ey..."
}
Renovar Token
GET /refrash-token
Cabeçalho: Authorization: Bearer <refreshToken>
Retorno: novo accessToken + refreshToken

| Método        | Rota            | Descrição                  |
| ------------- | --------------- | -------------------------- |
| GET           | `/Usuarios`     | Lista todos os usuários    |
| GET           | `/Usuarios/:id` | Busca usuário por ID       |
| POST          | `/Usuarios`     | Cria novo usuário          |
| PUT           | `/Usuarios/:id` | Atualiza usuário existente |
| DELETE        | `/Usuarios/:id` | Remove usuário             |
| ([GitHub][1]) |                 |                            |

[1]: https://github.com/ciafelina/TaskHub-API-Delphi.git "GitHub - ciafelina/TaskHub-API-Delphi: RESTful API for task management, built with Delphi and Horse."


| Método        | Rota           | Descrição                     |
| ------------- | -------------- | ----------------------------- |
| GET           | `/Tarefas`     | Lista tarefas (com paginação) |
| GET           | `/Tarefas/:id` | Busca tarefa por ID           |
| POST          | `/Tarefas`     | Cria nova tarefa              |
| PUT           | `/Tarefas/:id` | Atualiza tarefa existente     |
| DELETE        | `/Tarefas/:id` | Remove tarefa                 |
| ([GitHub][1]) |                |                               |

[1]: https://github.com/ciafelina/TaskHub-API-Delphi.git "GitHub - ciafelina/TaskHub-API-Delphi: RESTful API for task management, built with Delphi and Horse."

Parâmetros de listagem

limit: número máximo de registros por página (padrão: 10)

offset: índice inicial da página (padrão: 0)

sort: ordenação, ex: campo,asc;outro,desc

Filtros disponíveis:

Para Usuários: id, nome, email, Status

Para Tarefas: id, titulo, descricao, StatusTarefa, usuario_id, nome, email, StatusUsuario

🧩 Tecnologias usadas

Delphi

Horse framework

FireDAC / banco de dados relacional (configurado conforme ambiente)

JWT (JSON Web Token) para autenticação

🧑‍💻 Autor

Jose Thiago da Costa Marques
GitHub – ciafelina

