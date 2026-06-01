class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.7/anda-macos-arm64", using: :nounzip
      sha256 "fec9fe95186d1567ab223ee02de5b00f47030e009f580552c68abe7613de30bb"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.7/anda-macos-x86_64", using: :nounzip
      sha256 "6f3bdc60de32984658284c257d03076c05bf1e2dbed8183bddee2a546ebc417d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.7/anda-linux-arm64", using: :nounzip
      sha256 "38e3a7d6e8922bd77b5f8402ec7407234a4d3dad685a1ab8906f6f0454ca33e0"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.7/anda-linux-x86_64", using: :nounzip
      sha256 "7bba00864ed0b3460b8a9e79881fb077aff9ad3b8239ae84a33bedca7c466da1"
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
