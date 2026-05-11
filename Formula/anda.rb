class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.6.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.3/anda-macos-arm64", using: :nounzip
      sha256 "3f5dcf26e22cbca48af3f888f934f2ec99c74b31c1ec591afcce210dcee29542"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.3/anda-macos-x86_64", using: :nounzip
      sha256 "90ae9c3dde7996e363d325c39c25ae9990325bfe52a27493ef90242dc654d19e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.3/anda-linux-arm64", using: :nounzip
      sha256 "6d01d22c4f73e9997d2661caab374bdf950123c484063367af3a5c9e82523618"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.3/anda-linux-x86_64", using: :nounzip
      sha256 "f5e95da86a148b3c33677e996816a5820dd6ec3d9c95e5d98da69afa44c878c4"
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
