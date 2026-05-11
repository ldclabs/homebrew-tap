class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.6.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.4/anda-macos-arm64", using: :nounzip
      sha256 "5b7e1c84242bf4f69bdcf190de4b6097998cb68a5f134d2a1c026570b95d5e78"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.4/anda-macos-x86_64", using: :nounzip
      sha256 "2ea66c78b64f269df413c3ae9d943d265569bb0f7f69f1490942c6bc239e8f13"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.4/anda-linux-arm64", using: :nounzip
      sha256 "7da863374112d57db228e8559fb2d65b61ecfce98286816e621267f8fcdee35d"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.6.4/anda-linux-x86_64", using: :nounzip
      sha256 "8c7a6e9ec8119fa220d2f20c8d037c26882d6227252ce5faa20afc28bb777c3b"
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
