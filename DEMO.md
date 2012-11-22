# Redis
http://redis.io/

## Start demo

```
set foo bar
get foo
```

## Data structures demo
http://redis.io/commands

## OPERATIONS
```
set users:dima "{name: dima, planet: earth, likes: [trolling, spices]}"
strlen users:dima
getrange users:dima 27 40
append users:dima " OVER 9000!!"
```

## INCREMENTING
```
incr likes
incr likes
incrby likes 54
```

## EXPIRATION
```
expire pages:about 30
ttl pages:about
```

## RUBY EXAMPLE

```ruby
`ruby examples/redis.rb`

r = Redis.new
r.ping
r.set('foo','bar')
r.get('foo')
```

# MongoDB
http://www.mongodb.org/

## CREATING TABLES

SQL | MongoDB
------------ | -------------
CREATE TABLE boobs ( name VARCHAR(255), size INT ); |


## CREATING

SQL | MongoDB
------------ | -------------
INSERT INTO boobs VALUES('Pamela Anderson', 5); | db.boobs.insert({name: 'Pamela Anderson', size: 5})


## READING

SQL | MongoDB
------------ | -------------
SELECT * FROM boobs; | db.boobs.find()
SELECT name, size FROM boobs; | db.boobs.find({}, {name: true, size: true, _id: false})
SELECT * FROM boobs WHERE size = 3; | db.boobs.find({size: 3})
SELECT * FROM boobs WHERE size > 3; | db.boobs.find({size: {$gt: 3}})
SELECT * FROM boobs LIMIT 10; | db.boobs.find().limit(10)
SELECT * FROM boobs LIMIT 1; | db.boobs.findOne()
SELECT DISTINCT size FROM boobs; | db.boobs.distinct('size')
SELECT COUNT(1) FROM boobs; | db.boobs.count()

## UPDATING
SQL | MongoDB
------------ | -------------
UPDATE boobs SET size=6 WHERE name='Maria Rasputina'; | db.boobs.update({name: 'Maria Rasputina'}, {$set: {size: 6}, false, true}


## DELETING
SQL | MongoDB
------------ | -------------
DELETE FROM boobs WHERE size = 1; | db.boobs.remove({size: 1})
