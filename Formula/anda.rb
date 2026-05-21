class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.7.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.4/anda-macos-arm64", using: :nounzip
      sha256 "be37941161b969beecfe83cadb3cc36349c816e94b7d80e9a8cc066dcaf36061"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.4/anda-macos-x86_64", using: :nounzip
      sha256 "9541e1e75cff51d385b71c331485e875fe8af551a1937ecf702e3d42959507da"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.4/anda-linux-arm64", using: :nounzip
      sha256 "9a17d0e7365c7786b76e8018a34c75c69d1bfcb77d304661529f329fe8f8d964"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.4/anda-linux-x86_64", using: :nounzip
      sha256 "e1bc58a25d04249deefee4d21707438d46fa19cd670ca6f2f157b7b6594f76cf"
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
