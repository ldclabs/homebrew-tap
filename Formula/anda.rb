class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.4.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.4/anda-macos-arm64", using: :nounzip
      sha256 "40c2fb409290fc8791d21448fda9825ed53f3503656df659fc35cf01129cbc8f"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.4/anda-macos-x86_64", using: :nounzip
      sha256 "1895e19cf748f4626ceb112af3d6b16dc474512ad14d4127e1b02f460d4f023a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.4/anda-linux-arm64", using: :nounzip
      sha256 "51aea5d6e23d0c41e4de7274d16aef39e0f940b3f18c5ff5ad21a0126250a53b"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.4.4/anda-linux-x86_64", using: :nounzip
      sha256 "a89bb6a46f0f9aeba97f7f4f3a3aa2b72838adaf9a2f1e1c41f06ba40c79a837"
    end
  end

  def install
    binary = Dir["anda-*"].first
    chmod 0755, binary
    bin.install binary => "anda"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
  end
end
