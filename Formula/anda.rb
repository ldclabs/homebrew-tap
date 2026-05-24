class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.2/anda-macos-arm64", using: :nounzip
      sha256 "f5143d0da85656f9a7e3d10585c90bccd96bfb3d09c3e1a703d08720a5e25a5b"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.2/anda-macos-x86_64", using: :nounzip
      sha256 "1305df4ff0934789ae172bcea1eb72373e2493bbf69226988fffd4aca2c4f525"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.2/anda-linux-arm64", using: :nounzip
      sha256 "5764633074ddd4d4e018f9e4164e46e85a71843d5680a9ddf967f63be37521f3"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.2/anda-linux-x86_64", using: :nounzip
      sha256 "fa4139d67c0c61023bf5675995570db9d47f7f97869b4d5b5779a33472e1ebc5"
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
