class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.7/anda-macos-arm64", using: :nounzip
  sha256 "d77a24c127f3d685123066a2112484f02ece32a6b801f7917537f59b214703f1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.7/anda_launcher-macos-arm64", using: :nounzip
      sha256 "7fb28bac313bf4cd58bf1283d9dee78f7e79939d12c671462cc2bd166114098b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.7/anda-linux-arm64", using: :nounzip
      sha256 "f322207ada7e5bed6b34be041cd668560899ad7e0050815c92c6eb451c6e637c"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.7/anda-linux-x86_64", using: :nounzip
      sha256 "e5bc3ee3ea3f6cceb18c830a39cc8dd93a450a437a1f0600a044d474a03821c2"
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
