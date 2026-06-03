class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.9"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.9/anda-macos-arm64", using: :nounzip
      sha256 "d82cfcbc61ffee0c4791ec5a1fab45c644fab896ea794f69cc6327209b5e487c"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.9/anda-macos-x86_64", using: :nounzip
      sha256 "742f39bfd0428ba5e9053e21f0f9a85e8b2b75663c7f46b7558809f1f4176e88"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.9/anda-linux-arm64", using: :nounzip
      sha256 "c10f79ad646644734c3b80bfc3cb97cf24a09210db08ff35868820cc2b3d36dc"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.9/anda-linux-x86_64", using: :nounzip
      sha256 "7665a261d55accfc8fb2de9f3d93c1476e89414e838849c159bc53eff74bd42d"
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
