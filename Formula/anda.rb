class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.5.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.1/anda-macos-arm64", using: :nounzip
      sha256 "d302d545400e81dbe1cfe97fdb4cf4f3263fb9d2c66fe43ca7c1940afa0430d0"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.1/anda-macos-x86_64", using: :nounzip
      sha256 "4cc639e5c3a2eb227aba38614238558f54c84753849703c3e5fa11d782ac3456"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.1/anda-linux-arm64", using: :nounzip
      sha256 "8adba9f806565b93c94526b9291f70353fa2bfc5b06b0d78105ff0046106c9b8"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.1/anda-linux-x86_64", using: :nounzip
      sha256 "cc75807114638f0d2a42e0bb1e0113cc56c1a12a451c5f96495c45d2d273aba8"
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
