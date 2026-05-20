class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.7.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.3/anda-macos-arm64", using: :nounzip
      sha256 "62a9792eacd73c2e19a70fe2b9cca165389fbbb703bf7c13360d49d961bdb1ab"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.3/anda-macos-x86_64", using: :nounzip
      sha256 "4e19dc02f31a7ae19576971262c8acb834b6b8d1c0553dfc970d9ece904fed3f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.3/anda-linux-arm64", using: :nounzip
      sha256 "ec69e9a214908fa3fca214155284d6749756064ab2b6f090ebcf6721ca1acbf9"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.7.3/anda-linux-x86_64", using: :nounzip
      sha256 "6cf4db4f6bf4b1521195adfdb928aa81c9c8246e1617d0db2fdb1884d7559673"
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
