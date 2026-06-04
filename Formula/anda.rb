class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.11"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.11/anda-macos-arm64", using: :nounzip
      sha256 "88bd643a04d1dd74ebc0d25af99d6a087c52bb62272361f49578f9d7b7873434"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.11/anda-macos-x86_64", using: :nounzip
      sha256 "bceb5136ed53c3d7b93fba3b6da8d40e4896cf5344b352a8fa17cfc838c5ccb4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.11/anda-linux-arm64", using: :nounzip
      sha256 "67e831716c13068c693c1322d099a6ba74a3f6fbd8286b707124d5b8a8982d67"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.11/anda-linux-x86_64", using: :nounzip
      sha256 "1c2dacef21f63160fdf495de02d8178031d5af14b6e0baae42f87d18c588eb36"
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
