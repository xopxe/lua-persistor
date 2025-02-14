local lfs = require 'lfs'

local M = {}

local function purge_tree (path)
  local mode = lfs.attributes(path, 'mode')
  if mode == 'directory' then
    for file in lfs.dir(path) do
      if file ~= "." and file ~= ".." then
        purge_tree (path..'/'..file)
      end
    end
    lfs.rmdir(path)
  elseif mode == 'file' then
    os.remove(path)
  end
end

local supported_types = {
  ['string'] = function(s) return s end,
  ['number'] = tonumber,
  ['boolean'] = function (s) return s=='true' end,
}

local filepath_cache = setmetatable({}, {__mode='v'})

local function new_mt(p)
  local mt = {
    __index = function(_, key) 
      local filepath = p..'/'..key
      local mode = lfs.attributes(filepath, 'mode')
      if mode == 'directory' then
        local proxy = filepath_cache[filepath] or setmetatable({}, new_mt(filepath))
        filepath_cache[filepath] = proxy
        return proxy
      elseif mode == 'file' then
        local f = assert(io.open(filepath, 'r'))
        local valuetype = f:read('*l')
        local typecast = assert(supported_types[valuetype], 'unsupported type')
        local value = typecast( f:read('*a') )
        f:close()
        return value
      end
    end,
    __newindex = function(table, key, value)
      local filepath = p..'/'..key
      purge_tree(filepath)
      filepath_cache[filepath] = nil
      if type(value) == 'table' then
        assert(lfs.mkdir(filepath))
        --recursively add table content
        local subtable = table[key]
        for k, v in pairs(value) do
          subtable[k] = v
        end
      elseif value == nil then
        os.remove(filepath)
      else -- value ~= nil
        local f = assert(io.open(filepath, 'w'))
        f:write(type(value)..'\n'..tostring(value))
        f:close()
      end
    end
  }
  return mt
end

M.new = function (root, clear)
  root = root or assert(lfs.currentdir())..'/tmp-persistor'
  if clear then
    purge_tree(root)
  end
  if not lfs.attributes(root) then
    assert(lfs.mkdir(root))
  end
  return setmetatable({}, new_mt(root))
end

return M
