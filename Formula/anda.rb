class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.3/anda-macos-arm64", using: :nounzip
  sha256 "6a74adc9e6881ea094b2066ee48bf0590b1a04eb160d3c14063aef382c67076c"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.3/anda_launcher-macos-arm64", using: :nounzip
      sha256 "1446277f43a75c7ef56cd2485e65abd73d1d5548d00d6815c492fc8a0259bc66"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.3/anda-linux-arm64", using: :nounzip
      sha256 "e6fd3017e178cb974f8839820bab2c4b067c1fb022d645f975ac29bb162a4571"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.3/anda-linux-x86_64", using: :nounzip
      sha256 "11cf1376e1173aa7512103c431ef766d04cc2a03974f46717f0c2623a0da590f"
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
