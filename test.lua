local persistor = require 'persistor'

local lfs = require 'lfs'

local path = assert(lfs.currentdir())..'/tmp-persistor'
print ('using '..path..' for data')

local p

---[[
--Create a new persistent table, ensure it's clear
p = persistor.new(path, true)
p.aaa = {} 
p.bbb = 'lorem\nipsum'
p.ccc = 3.14
p.aaa.ddd={eee=false}
--]]

---[[
-- Use the stored data
p = nil;collectgarbage();collectgarbage()
p = persistor.new(path)
print ('read1->', p.aaa)
print ('read2->', type(p.bbb), p.bbb)
assert(p.bbb == 'lorem\nipsum')
print ('read3->', type(p.ccc), p.ccc)
assert(p.ccc == 3.14)
print ('read4->', type(p.aaa.ddd.eee), p.aaa.ddd.eee)
assert(p.aaa.ddd.eee==false)
--]]
