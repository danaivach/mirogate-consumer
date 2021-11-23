# mirogate-consumer

1. Clone the repository: 	
```
git clone git@github.com:danaivach/mirogate-consumer.git --recursive
```
2. Register as an operator of leubot to get an API key on [SwaggerHub](https://interactions-hsg.github.io/leubot/#/user/addUser) or with cURL:
```
curl -i -X 'POST' 'https://api.interactions.ics.unisg.ch/leubot1/v1.3.0/user' -H 'Content-Type: application/json' -d '{
  "name": "Danai V.",
  "email": "danai.vachtsevanou@unisg.ch"
}'
```
3. Run the example app with the API key for the leubot:
```
./gradlew run --args="apikey"
```

### Used [TDs](https://www.w3.org/TR/wot-thing-description/)
- leubot: https://github.com/Interactions-HSG/example-tds/blob/main/tds/leubot1.ttl 
- mirogate: https://github.com/Interactions-HSG/example-tds/blob/main/tds/mirogate.ttl 
