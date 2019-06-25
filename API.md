
## sortbot API


### Query sortbot

`GET https://api.noopschallenge.com/sortbot`

`HTTP 200`

```
{
  "message": "Hello there, welcome to the Sortbot. Get started at /sortbot/exam"
}
```


### Start the sortbot exam

`POST https://api.noopschallenge.com/sortbot/exam/start`


```
{
 "login": "test"
}
```

`HTTP 200`

```
{
  "message": "Hello test, get ready for all sorts of fun. Get it?",
  "nextSet": "/sortbot/exam/3qm7iTRNtpn8NIUqtBubvQ"
}
```


### Answer first question

`POST https://api.noopschallenge.com/sortbot/exam/3qm7iTRNtpn8NIUqtBubvQ`


```
{
 "solution": [
  32,
  35,
  40,
  46,
  52,
  53,
  73,
  80,
  95,
  96
 ]
}
```

`HTTP 200`

```
{
  "result": "success",
  "message": "Great job!",
  "elapsed": 0,
  "nextSet": "/sortbot/exam/6YXxoDcJDtzp8Aj3iY0W0A"
}
```
