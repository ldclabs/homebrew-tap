class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.4.0-beta-3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.0-beta-3/anda-macos-arm64", using: :nounzip
      sha256 "51ebf789663ae4ad5edd382fa317d0915d94ab6992c194de0205c0123546e0cc"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.0-beta-3/anda-macos-x86_64", using: :nounzip
      sha256 "74482b92d422c4c757aad38b8060609cdc2c2164229d17f165b44534545d50aa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.0-beta-3/anda-linux-arm64", using: :nounzip
      sha256 "0d66db86e687e82d304ea0e9539dd3c580cb77450809379c525449f8b5662cc3"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.0-beta-3/anda-linux-x86_64", using: :nounzip
      sha256 "6ae2642d1b0c9d9a3102328d333d3953d097ca47d374b7eff9ec439f6886fd45"
    end
  end

  def install
    binary = Dir["anda-*"].first
    chmod 0755, binary
    bin.install binary => "anda"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
  end
end
