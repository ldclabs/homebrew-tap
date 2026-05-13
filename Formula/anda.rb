class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.0/anda-macos-arm64", using: :nounzip
      sha256 "c4c61f924fb57a11783b7e88e515c89cf84c8f3167aee286759d19a5f8328dd8"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.0/anda-macos-x86_64", using: :nounzip
      sha256 "9833c5b183183bbc7df3b090febe1d4452e23b050ccec18b8646044bf5d39e15"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.0/anda-linux-arm64", using: :nounzip
      sha256 "b8c51d722761de17fe7eaa77970a81035b4fe99824a5adae880300484826a2bb"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.0/anda-linux-x86_64", using: :nounzip
      sha256 "de2282e1629bc873a850978e0803327ae6b909b5738d0e3dfe127d42ef0507b2"
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
