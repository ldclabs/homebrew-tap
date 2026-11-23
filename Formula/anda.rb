class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.1/anda-macos-arm64", using: :nounzip
  sha256 "c5e953b44230ddf498a24f4cb7b1ce1642c50f5e42710941b90a93e4da919f2b"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.1/anda_launcher-macos-arm64", using: :nounzip
      sha256 "c916b03233115461c5b45e6370abc84b301251f08b6cfac77d8c02be4242cb96"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.1/anda-linux-arm64", using: :nounzip
      sha256 "5b2c7b46ec83e9af46e4860d9744cc3a787b62e53cec97b94329fa32182af430"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.15.1/anda-linux-x86_64", using: :nounzip
      sha256 "42ee83f1d0a950b47d7d2a339da64393b23487d91396ef47e2d8ebfb0b17e530"
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
