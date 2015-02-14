require "formula"

class Luarocks51 < Formula

  homepage "http://luarocks.org"
  url "http://luarocks.org/releases/luarocks-2.2.0.tar.gz"
  sha1 "e2de00f070d66880f3766173019c53a23229193d"
  revision 1

  bottle do
    sha1 "eabd3d0f2bb7979ac831ce948e8d288569d2a0c8" => :mavericks
    sha1 "fb6956c0ee42f3bfdde280693cf28d32b3587e55" => :mountain_lion
    sha1 "140ee3fd55954d1fd30984620d8f109056ef56f9" => :lion
  end

  head "https://github.com/keplerproject/luarocks.git"

  option "with-luajit",  "Use LuaJIT instead of Lua 5.1"

  if build.with? "luajit"
    depends_on "luajit"
  else
    depends_on "lua51"
  end

  fails_with :llvm do
    cause "Lua itself compiles with llvm, but may fail when other software tries to link."
  end

  def install
    args = []
    args << "--prefix=#{prefix}"
    args << "--rocks-tree=#{HOMEBREW_PREFIX}"
    args << "--sysconfdir=#{etc}/luarocks"
    args << "--versioned-rocks-dir"
    if build.with? "luajit"
      lua_prefix = Formula["luajit"].opt_prefix
      args << "--with-lua=#{lua_prefix}"
      args << "--lua-version=5.1"
      args << "--lua-suffix=jit"
      args << "--with-lua-include=#{lua_prefix}/include/luajit-2.0"
    else
      lua_prefix = Formula["lua51"].opt_prefix
      args << "--with-lua=#{lua_prefix}"
      args << "--lua-version=5.1"
      args << "--lua-suffix=5.1"
      args << "--with-lua-include=#{lua_prefix}/include/lua-5.1"
    end
    system "./configure", *args
    system "make", "build"
    system "make", "install"
    system "rm", "#{prefix}/bin/luarocks" # remove symlink
    system "rm", "#{prefix}/bin/luarocks-admin" # remove symlink
    if build.with? "luajit"
      system "mv", "#{prefix}/bin/luarocks-5.1", "#{prefix}/bin/luarocks-jit" # rename
      system "mv", "#{prefix}/bin/luarocks-admin-5.1", "#{prefix}/bin/luarocks-admin-jit" #r ename
    end
  end

  def caveats
    if build.with? "luajit"
      print "Luarocks is available at: #{HOMEBREW_PREFIX}/bin/luarocks-jit\n"
    else
      print "Luarocks is available at: #{HOMEBREW_PREFIX}/bin/luarocks-5.1\n"
    end
    print "Rocks install to: #{HOMEBREW_PREFIX}/lib/luarocks/rocks-5.1\n"
    print "A configuration file has been placed at: #{HOMEBREW_PREFIX}/etc/luarocks/config-5.1.lua\n"
  end

  test do
    if build.with? "luajit"
      system "#{bin}/luarocks-jit", "install", "say"
    else
      system "#{bin}/luarocks-5.1", "install", "say"
    end
  end

end