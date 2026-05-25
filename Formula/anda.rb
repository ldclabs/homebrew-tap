class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.4/anda-macos-arm64", using: :nounzip
      sha256 "fb328f43d414952d1ca78155fb4d49cb45392812e5bac431b06913d577c2b0ad"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.4/anda-macos-x86_64", using: :nounzip
      sha256 "28b20901ae89b09bf3579d126a0f7cf0293b2ffd327d81325e16ba85dc22f9a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.4/anda-linux-arm64", using: :nounzip
      sha256 "464a879ede8afc30b5c5682d2e11d2b7425843a8073604decac403b3c0093271"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.4/anda-linux-x86_64", using: :nounzip
      sha256 "094667eaaf5648636b1c10df5b4c75c007f708fdbff29ea0f5dc28caea354ec3"
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
