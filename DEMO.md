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

## HASHES
```
hset users:goku powerlevel 9000
hget users:goku powerlevel
```
```
hmset users:goku race saiyan age 737
hmget users:goku race powerlevel
hgetall users:goku
hkeys users:goku
hdel users:goku age
```

## LISTS
```
rpush newusers goku
ltrim newusers 0 50
lrange newusers 0 10
```

## SETS

```
sadd friends:leto ghanima paul chani jessica
sadd friends:duncan paul jessica alia
```

* Regardless of how many friends a user has, we can efficiently tell (O(1)) whether userX is a
friend of userY or not:

```
sismember friends:leto jessica
sismember friends:leto vladimir
```

* Furthermore we can see what two or more people share the same friends:

```
sinter friends:leto friends:duncan
```

* and even store the result at a new key:

```
sinterstore friends:leto_duncan friends:leto friends:duncan
```

## SORTED SETS
```
zadd friends:john 100 ghanima 95 paul 95 chani 75 jessica 1 vladimir
```
* Want to find out how many friends leto has with a rank of 90 or over?

```
zcount friends:john 90 100
```
* How about figuring out chanis rank?

```
zrevrank friends:john chani
```
## EXPIRATION
```
expire pages:about 30
ttl pages:about
```

## SORTING
```
rpush users:leto:guesses 5 9 10 2 4 10 19 2
sort users:leto:guesses
```

* The above command shows us how to page the sorted records (via limit), how to return the
results in descending order (via desc) and how to sort lexicographically instead of numerically
(via alpha).

```
sadd friends:ghanima leto paul chani jessica alia duncan
sort friends:ghanima limit 0 3 desc alpha
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
SELECT * FROM boobs WHERE name LIKE "%Pamela%"; | db.boobs.find({name: /Pamela/})
SELECT * FROM boobs WHERE name LIKE "Pamela%"; | db.boobs.find({name: /^Pamela/})
SELECT * FROM boobs WHERE size > 3 AND name = 'Kirsten Dunst'; | db.boobs.find({size: 3, name: 'Kirsten Dunst'})
SELECT * FROM boobs WHERE size > 3 AND size < 5; | db.boobs.find({size: {$gt: 3, $lt: 5}})
SELECT * FROM boobs WHERE size > 3 OR name='Mischa Barton'; | db.boobs.find({$or: [{size: 3},  {name: 'Mischa Barton'}]})
SELECT * FROM boobs WHERE size=4 ORDER BY name; | db.boobs.find({size: 4}).sort({name: 1})
SELECT * FROM boobs ORDER BY name DESC; | db.boobs.find().sort({name: -1})
SELECT * FROM boobs LIMIT 10; | db.boobs.find().limit(10)
SELECT * FROM boobs LIMIT 1; | db.boobs.findOne()
SELECT DISTINCT size FROM boobs; | db.boobs.distinct('size')
SELECT COUNT(1) FROM boobs; | db.boobs.count()


## UPDATING
SQL | MongoDB
------------ | -------------
UPDATE boobs SET size=6 WHERE name='Maria Rasputina'; | db.boobs.update({name: 'Maria Rasputina'}, {$set: {size: 6}, false, true}
UPDATE boobs SET size=size+2 WHERE name='Madonna'; | db.boobs.update({name: 'Madonna'}, {$inc: {size: 2}}, false, true)

## DELETING
SQL | MongoDB
------------ | -------------
DELETE FROM boobs WHERE size = 1; | db.boobs.remove({size: 1})

## INDEXING
SQL | MongoDB
------------ | -------------
UPDATE boobs SET size=6 WHERE name='Maria Rasputina'; | db.boobs.update({name: 'Maria Rasputina'}, {$set: {size: 6}, false, true}
UPDATE boobs SET size=size+2 WHERE name='Madonna'; | db.boobs.update({name: 'Madonna'}, {$inc: {size: 2}}, false, true)

