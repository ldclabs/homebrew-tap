class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.10/anda-macos-arm64", using: :nounzip
  sha256 "d8e2b43781a0e7f4341949fed6f45b2c01a4c34a1b8504823c0b5eaba20444a1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.10/anda_launcher-macos-arm64", using: :nounzip
      sha256 "c53a8ef4596713454be0431417bbfd407b7645931c1daf17ffea6851054f7018"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.10/anda-linux-arm64", using: :nounzip
      sha256 "6be05cf7d96ccf9089f40fe0dd628edde00094430e7826b8ac68eb84e18fb9ba"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.10/anda-linux-x86_64", using: :nounzip
      sha256 "ddb2c2730cc8ac4faf51d6161a129964a665a9a87b7e40af76c8ef84952cf5a5"
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
