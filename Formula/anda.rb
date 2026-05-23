class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.0/anda-macos-arm64", using: :nounzip
      sha256 "83b9a47f458d01dd03a7f4dc5dc1e8d40e2779f2f929b2ee3c51de5fda394016"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.0/anda-macos-x86_64", using: :nounzip
      sha256 "8bd0926701b9885e6ea6f0f9baa8402d12f495e69fc31ea38d82a050e624427b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.0/anda-linux-arm64", using: :nounzip
      sha256 "089da6959cda77da92dd3ca25aac02a780b36bc7bc6d071f02ae7156202bd7ff"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.0/anda-linux-x86_64", using: :nounzip
      sha256 "c6a24ef6c6560999c1de5f3659aa279a6c9871ac65017914b0781335e0805b73"
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
