class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.7.7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.7/anda-macos-arm64", using: :nounzip
      sha256 "6125dfd211826768bdbf925121bedc3e86468217a04463aa197cfeb86fb9ba3d"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.7/anda-macos-x86_64", using: :nounzip
      sha256 "64af328dbd646c8616eac59fe6cc2ca1f2cc25c2905d40f6d4af9e03204197b8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.7/anda-linux-arm64", using: :nounzip
      sha256 "c604793c1a66c221c29155916d554177deadbe0ccfa2309312c92a029e300b94"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.7/anda-linux-x86_64", using: :nounzip
      sha256 "7c0e5252a18db38913118c25e32d88897cf6a3a40d6076db7e87b89d372bd36d"
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
