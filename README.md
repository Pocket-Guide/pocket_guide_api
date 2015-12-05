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


### How to get current_tourist

by using access token, you can get current_user.
Let's try as below.

```
curl -s -XGET -H "Authorization: Bearer (access_token)" http://localhost:3000/tourists
```

### How to create tourist

- url: http://localhost:3000/tourists

- http type: POST

- necessary parameters: email, password, password_confirmation, name




### Planning Flow

####1. Create Tour

Tour is a package. You have to create a tour before answering some questions.

#####Tour column

- content: text
- tourist_id: integer

#####How to post

- http type: POST

- path: `/current_tourist/me/tours`


####2. get questions

##### how to get questions

- Http type: GET

- path: `/current_tourist/me/questions`

####3. Post answers

##### How to post answers

- Http type: POST

- path: `/current_tourist/me/answers`
