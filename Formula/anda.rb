class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.0/anda-macos-arm64", using: :nounzip
      sha256 "49f5f1df9a1dc852bb50720f0aad369e391ba2260131f58129a938eff23a0f42"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.0/anda-macos-x86_64", using: :nounzip
      sha256 "6c4b6a65ce436f7ee4bcb4abb25cae613b5445e90ed653331ca0c945dcb72a04"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.0/anda-linux-arm64", using: :nounzip
      sha256 "735fd69cbc71da4ada3d500d6e72585775724d3c6890e4407c4e041d6c2b9c1d"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.0/anda-linux-x86_64", using: :nounzip
      sha256 "5e4c44b93b5155412aee26a90cbcda4d7e2fa19b204e7ec9520db09f8b3a47ac"
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
