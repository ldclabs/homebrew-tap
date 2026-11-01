class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.9/anda-macos-arm64", using: :nounzip
  sha256 "efed9d1cd8d47192fbaeb0f3fdc5bcd0e8b918c69bbed4da5294857d5e7a670f"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.9/anda_launcher-macos-arm64", using: :nounzip
      sha256 "c225b6e14d8535d124f1819e6ad7a688eb10574b1e49e0fb3482652956b5164b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.9/anda-linux-arm64", using: :nounzip
      sha256 "cd1c619e2d6f88561ba745627b044313e34ba4f8b196f72e20e2316fc6d8a140"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.9/anda-linux-x86_64", using: :nounzip
      sha256 "461747a9cb26e0291ae72d49268aeb92062df067bdf3854429d43e30b46b6be4"
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
