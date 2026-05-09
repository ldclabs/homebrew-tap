class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.5.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.4/anda-macos-arm64", using: :nounzip
      sha256 "9f1f9ad671ae218a0c482e9f7dd6119c9faaafa8a58b3724462b081b4ce1e892"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.4/anda-macos-x86_64", using: :nounzip
      sha256 "fa77885fe05ac8d291fbb606f1c5ca1878b641426b91bbd04a72a07a6a18474e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.4/anda-linux-arm64", using: :nounzip
      sha256 "c831404f93454ace6e9e1ecd5b6fd8c3ff06cbe4789149d8ab920a2e765d212b"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.5.4/anda-linux-x86_64", using: :nounzip
      sha256 "a9679f475d96b92c76685eb969776fd3b5033a911e7d7f31f293caacddd5b75f"
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
