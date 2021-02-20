- terraform vars reworked in 0.12
- more control over vars, and for and for-each loops which were not possible before
- you don't have to specify types in vars, but it is recommended
- simple var types:
  - string
  - number
  - bool

- complex types:
  - List(type)
  - Set(type)
  - Map(type)
  - Object({ATTR NAME = TYPE, ...}
  - Tuple([Type, ...])

- List and map were previously covered
  - List: [0, 1, 5, 2]
    - A list is always ordered, it'll always return out what is put in (won't change order from 0,1,5,2 to 5,1,2,0)
  - Map: {"key": "value"}
  - Set like a list, but doesn't preserve order and can only contain unique vals
    - List that contains [5, 1, 1, 2] becomes [1, 2, 5] in a set (when you output, terraform will sort it)

- An object is like a map, but each element can have a different type
 - { firstname = "John", housenumber = 10}

- A tuple is like a list, but each element can have a different type:
 - [0, "string", false]

ones to remember getting started:

 - string, number, bool, and list & map
  