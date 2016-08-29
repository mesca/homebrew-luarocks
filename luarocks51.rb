require "formula"

class Luarocks51 < Formula

  homepage "http://luarocks.org"
  url "http://keplerproject.github.io/luarocks/releases/luarocks-2.3.0.tar.gz"
  sha1 "68e38feeb66052e29ad1935a71b875194ed8b9c67c2223af5f4d4e3e2464ed97"
  revision 1

  bottle do
    sha256 "56ec46f48303ede0210a6f5cb0ebb82ffd088002e12c3698271af946b3460eeb" => :el_capitan
    sha256 "df3c611fc103491b9aeb5357bcd2a49830e72bdd89d73827acf32da7ebc136a7" => :yosemite
    sha256 "df14dde529876d335709841750c65e2216038819fae2efe3cffdcb4057812e57" => :mavericks
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