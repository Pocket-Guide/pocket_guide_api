# What kind of API

### Introduction

Please launch 'pocket_guide_api'
if you launch at http://localhost:3000, you can get api as below.

### How to create access token

1, connect to http://localhost:3000/oauth/applications
2, register your client application. Then you can get client_id and client_secret

3, if you access as below, you can get access token

```
curl -u "client_id:client_secret_key" -XPOST http://localhost:3000/oauth/token -d 'grant_type=password&email=hogehoge@example.com'

```

- http type: POST

- necessary parameter: grant_type, and authenticaton flag


### How to get current_user

by using access token, you can get current_user.
Let's try as below.

```
curl -s -XGET -H "Authorization: Bearer (access_token)" http://localhost:3000/users
```

### How to create user

- url: http://localhost:3000/users

- http type: POST

- necessary parameters: email, password, password_confirmation, name

