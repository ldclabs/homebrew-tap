class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.13"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.13/anda-macos-arm64", using: :nounzip
      sha256 "56be1c4e4a321456e536bcb8d0f55342235e3fa48c0fb5c83c79551a52a7c6b3"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.13/anda-macos-x86_64", using: :nounzip
      sha256 "ed4de7fdca1a784da1db1017986055c5cba5381b4ef7d76fb0dc862d8f350503"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.13/anda-linux-arm64", using: :nounzip
      sha256 "0b178386bdd8d5b25efb58b91bd23dce4097dbb63c7800917f4e0923885fc121"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.13/anda-linux-x86_64", using: :nounzip
      sha256 "5edc553a003242d85a2ce66ae38d92e7d8a9172b5c7b94e941f7b2289d70e39e"
    end
  end

  def install
    binary = Dir["anda-*"].first
    chmod 0755, binary
    bin.install binary => "anda"
  end

  def caveats
    <<~EOS
      Homebrew does not write runtime files into ~/.anda during install.
      To install or refresh curated skills, run:
        anda update --skills
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
  end
end
