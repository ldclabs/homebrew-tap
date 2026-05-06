class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.0/anda-macos-arm64", using: :nounzip
      sha256 "2e28c63f0fb0b4c2535eb6605b65ef052ea84bf1b4ff958815de254d09cce814"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.0/anda-macos-x86_64", using: :nounzip
      sha256 "9775ebfe430ba4e14c2cd441f314e9b500f66ec54790ba2a46776bdee7fc3658"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.0/anda-linux-arm64", using: :nounzip
      sha256 "1d69bbc416dceca364e00e7a92968ed5c777d392aebcc56cc4814d287d8fbbe0"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.0/anda-linux-x86_64", using: :nounzip
      sha256 "18dfae226606c727e6646bf2c4afc857650ab9726af60c35a45ea0548754f893"
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
