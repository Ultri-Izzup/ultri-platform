# Izzup - Fediverse Accounts

```mermaid
flowchart TD 
User(Visitor to Ultri.com)--SuperTokens Passwordless Auth--> Ultri(Join Ultri)
Ultri--Member record for email gets created-->Postgres
Postgres--Member enters social info and password-->UltriAPI(Social user created)
```

