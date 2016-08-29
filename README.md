# Homebrew-luarocks

These formulae provide non-conflicting alternative versions of [LuaRocks](https://rocks.moonscript.org).

Two formulae are currently available:

- LuaRocks for Lua 5.1 (with optional LuaJIT support)
- LuaRocks for Lua 5.3

They can be installed alongside LuaRocks for Lua 5.2, which is available from the main tap.

## Installing

### For Lua 5.1

It is as simple as:
```
brew tap mesca/luarocks
brew install luarocks51 [--with-luajit]
```

You can also install directly from URL:
```
brew install https://raw.githubusercontent.com/mesca/homebrew-luarocks/master/luarocks51.rb [--with-luajit]
```

LuaRocks is then available as `luarocks-5.1` or `luarocks-jit`, depending of the selected option.

### For Lua 5.3

First install Lua 5.3:
```
brew tap homebrew/versions
brew install lua53
```

Install LuaRocks:
```
brew tap mesca/luarocks
brew install luarocks53
```

Or directly from URL:
```
brew install https://raw.githubusercontent.com/mesca/homebrew-luarocks/master/luarocks53.rb
```

LuaRocks is then available as `luarocks-5.3`.
