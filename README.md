# Homebrew-luarocks

These formulae provide non-conflicting alternative versions of [LuaRocks](https://rocks.moonscript.org).

For now, the only formula available here is LuaRocks for Lua 5.1 (with optional LuaJIT support).

## Installing

It is as simple as:
```
brew tap mesca/luarocks
brew install luarocks51 [--with-luajit]
```

You can also install directly from URL:
```
brew install https://raw.githubusercontent.com/mesca/homebrew-luarocks/master/luarocks51.rb [--with-luajit]
```

LuaRocks is then available as `luarocks-5.1` or `luarocks-jit`. That means this formula can be installed alongside LuaRocks for Lua 5.2, which is available from the main tap.