class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.3/anda-macos-arm64", using: :nounzip
      sha256 "d5ba02625bbe4db02cec891f021ffa1094f721e17c2d03fa26c8108a31f4dfba"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.3/anda-macos-x86_64", using: :nounzip
      sha256 "5c1b695e252320ebd1ece60ab48352bff9710ef1f4630da75a30d503ebf20bd5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.3/anda-linux-arm64", using: :nounzip
      sha256 "c5b71e6005ba3980938269fb9ec89485d755582a4e5a87e61790103bdae7cae1"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.3/anda-linux-x86_64", using: :nounzip
      sha256 "e19036ad3625aff5efc961efd798f32734963c4fb184c26254b627e02ac0f801"
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
