local persistor = require 'persistor'

local p = persistor.new()
p.aaa = {} 
local ret = p.aaa
print ('read1->', ret)
print ('comp1->', ret==p.aaa)
ret.bbb = 'lorem ipsum'
print ('read2->', type(ret.bbb), ret.bbb)
ret.ccc = 3.14
print ('read3->', type(ret.ccc), ret.ccc)
p.aaa.ddd={eee=true}
print ('read4->', type(p.aaa.ddd.eee), p.aaa.ddd.eee)
ret.bbb= nil
assert (ret.bbb == nil)
assert (type(ret.bbb) == 'nil') 
