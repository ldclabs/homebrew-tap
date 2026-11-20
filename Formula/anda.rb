class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.0/anda-macos-arm64", using: :nounzip
  sha256 "1206a53c51e2da349c72266f3f55feeb73545946bb9d932f68900edafa3104ee"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.0/anda_launcher-macos-arm64", using: :nounzip
      sha256 "4a100c4f3a29948e1c7d9931adabfc2b8d389431c72c30eb7bc5d950cb29d29d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.0/anda-linux-arm64", using: :nounzip
      sha256 "662c9875d765b74e91ac0d3182ea4825958256ee7ab350ca63e57232a922c66c"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.0/anda-linux-x86_64", using: :nounzip
      sha256 "0de57e5daa8a91ed25c85aa054cc2fce05b57ad93b8f2eaf6b63e86ddfaea737"
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
