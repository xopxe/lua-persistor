lua-persistor
=============

Transparent persistence for Lua data! Seriously!

* Depends on luafilesystem
* Keys can only be strings valid as filenames
* Can store/retrieve tables (no loops!), strings, numbers and booleans.
* Contains a recursive directory purger, handle with care.
 


How?
----

```lua
-- load library
local persistor = require 'persistor'

-- get a persistor table.
-- if the root folder exists, data will be read from there.
-- if the name is omitted "$PWD/tmp-persistor" will be used.
-- if there was data from previous executions, it will still be there.
-- data inside this folder is used at will, do not use it for anything else
local p = persistor.new('path/to/root/folder')

-- also you can purge all stored data loading the persistor table as follows:
-- local p =  persistor.new('path/to/root/folder', true)

-- store something
p.pi = 3.14
p.circle = {center={x=0, y=0}, radius=0.5}

-- read something (possibly much later, in another run)
print (2 * p.pi * p.circle.radius)
```

Who?
----
xxopxe@gmail.com
