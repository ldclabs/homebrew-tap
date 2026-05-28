class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.5/anda-macos-arm64", using: :nounzip
      sha256 "13d26bb4feae04d6910103f8ec44e57c964e64f7ba074c04bbb4205786ec211d"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.5/anda-macos-x86_64", using: :nounzip
      sha256 "884d9e670fb3d437fb6bf96bebaa701d87314cd4af8f66bae842ccacf212b71c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.5/anda-linux-arm64", using: :nounzip
      sha256 "61def28c3e33b2a4ffd15f47811eeeb54635903bf4e8a28817a268cad21c4477"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.5/anda-linux-x86_64", using: :nounzip
      sha256 "9584cc974b8bb1f9434857ffc07c6edaee3f975429e5cd13e681fc40e41d105e"
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
