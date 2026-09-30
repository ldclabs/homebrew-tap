class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.1/anda-macos-arm64", using: :nounzip
  sha256 "94a67c865af60c379742540abfcc9dde93461508d0f1ad2a921a1859bbd05561"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.1/anda_launcher-macos-arm64", using: :nounzip
      sha256 "e298839ec63f2cece751d677879157eed34a13d8415d881d3153febe1fd1b14b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.1/anda-linux-arm64", using: :nounzip
      sha256 "1269aa776feb2f7615fb90e3f37172e25c6f4485fb8a2b4b6e513881632924c3"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.1/anda-linux-x86_64", using: :nounzip
      sha256 "af434708229482fb33f4df8f52fda7754dde31386eabf8f8cf619d1318b53492"
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
