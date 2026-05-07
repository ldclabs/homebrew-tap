class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.5.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.2/anda-macos-arm64", using: :nounzip
      sha256 "c9638e2a68445bf3467306a6ad4e3132c594b25e401942377bbefd335914aa0a"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.2/anda-macos-x86_64", using: :nounzip
      sha256 "75d78798d1696aae37dd44602049d14351253b8191f29baff5cf53f8c1c70a88"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.2/anda-linux-arm64", using: :nounzip
      sha256 "9d4a2674af9f8c2f6924f803c6699e8ae63c32e5d29f0b07f296ad1d197edcaa"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.2/anda-linux-x86_64", using: :nounzip
      sha256 "f498f18e319068534aa7a8317980cae1b367a492a8e96032eb18d589f8b4f8ac"
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
        anda update --skills-only
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
  end
end
