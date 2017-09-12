class Icu4c58 < Formula
  desc "C/C++ and Java libraries for Unicode and globalization"
  homepage "http://site.icu-project.org/"
  url "https://ssl.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz"
  version "58.2"
  sha256 "2b0a4410153a9b20de0e20c7d8b66049a72aef244b53683d0d7521371683da0c"

  bottle do
    cellar :any
  end

  keg_only :provided_by_osx, "macOS provides libicucore.dylib (but nothing else)"

  def install
    args = %W[--prefix=#{prefix} --disable-samples --disable-tests --enable-static]
    args << "--with-library-bits=64" if MacOS.prefer_64_bit?

    cd "source" do
      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/gendict", "--uchars", "/usr/share/dict/words", "dict"
  end
end
