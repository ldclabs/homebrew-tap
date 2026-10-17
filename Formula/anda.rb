class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.4/anda-macos-arm64", using: :nounzip
  sha256 "4fb5c1f76b54d405914097643c179881f95f348b7b2ef5b3bb5e86a6537c42e7"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.4/anda_launcher-macos-arm64", using: :nounzip
      sha256 "34571d41d60143228386687dd334978a633bbccf272a985135d49ea95a6d6318"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.4/anda-linux-arm64", using: :nounzip
      sha256 "d595026c01626d491c5de70fa3167a7e0e55e7b96f35e85786730de6cbb30e62"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.4/anda-linux-x86_64", using: :nounzip
      sha256 "dae8d7624b98aa4e4b712411d7a1d8f9d841f70082131ac41d36b30d700f99b5"
    end
  end

  def install
    binary = Dir["anda-*"].first
    chmod 0755, binary
    bin.install binary => "anda"

    if OS.mac?
      resource("anda_launcher").stage do
        launcher = Dir["anda_launcher-*"].first
        chmod 0755, launcher
        bin.install launcher => "anda_launcher"
      end
    end
  end

  def caveats
    lines = [
      "Homebrew does not write runtime files into ~/.anda during install.",
      "To install or refresh curated skills, run:",
      "  anda update --skills",
      "",
      "After upgrading an already running daemon, restart it to use the new binary:",
      "  anda restart",
    ]

    if OS.mac?
      lines += [
        "",
        "The tray, chat window and settings are in Anda Desktop, which uses this anda:",
        "  brew install --cask ldclabs/tap/anda-desktop",
        "anda_launcher only retires the old Anda Bot menu bar launcher and will be removed.",
      ]
    end

    lines.join("\n")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
    assert_path_exists bin/"anda_launcher" if OS.mac?
  end
end
