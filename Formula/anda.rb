class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.1/anda-macos-arm64", using: :nounzip
      sha256 "20d4aebd9cb9d6731cd606db0a864e235587c10a264fae5d5aac0900e8757850"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.1/anda-macos-x86_64", using: :nounzip
      sha256 "3db67291447ed57676a234375815460e32879fabfd83a4eae26a9c9064e70d09"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.1/anda-linux-arm64", using: :nounzip
      sha256 "806a665bfff31ae93734991b69823ea8def467a92115fd71de7c75e6b12cc1bb"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.1/anda-linux-x86_64", using: :nounzip
      sha256 "04fbea1aa41d72122dc7090df5960d4a6be73555533c56598b7b3d0a2076aeeb"
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
