lua-persistor
=============

Transparent persistance for Lua data! Seriously!

* Depends on luafilesystem
* Keys can only be strings valid as filenames
* Can store/retrieve tables, strings, numbers and booleans.
* Contains a recursive directory purger, handle with care.


Howto
=====

```
-- load library
local persistor = require 'persistor'

-- get a persistor table
-- if the root folder exists, data will be read from there.
local p = persistor.new('path/to/root/folder')

-- store something
p.pi = 3.14
p.circle = {center={x=0, y=0}, radius=0.5}

-- read something (possibly much later)
print ( 2 * p.pi * p.circle.radius)
```

Who?
====
xxopxe@gmail.com
