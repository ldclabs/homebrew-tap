class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.5.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.3/anda-macos-arm64", using: :nounzip
      sha256 "e9204daae81bd88a5705c50cf4e75b1e3013998477fb4b9c910e4632c91b6516"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.3/anda-macos-x86_64", using: :nounzip
      sha256 "f7eeca6aa6303e31969d319e527756b499e20635cc2937ba2f279130419182e6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.3/anda-linux-arm64", using: :nounzip
      sha256 "ac254ab7579b750e3772c7eeaa42a7e92318fd0d60e6fb789c5f9d43a8137628"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.3/anda-linux-x86_64", using: :nounzip
      sha256 "191c130b8fd2212651ad928a0607b92844a17e9554381fd70e141fc5c87ec527"
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
