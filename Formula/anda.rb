class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.1/anda-macos-arm64", using: :nounzip
  sha256 "2db9a23c1423b910371ba16cbc8b2c025e899ad1eb282572adf86bd559a512da"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.1/anda_launcher-macos-arm64", using: :nounzip
      sha256 "1718ee7121c4d92bd6bbb75cfe355fbc8cf16efd2b8afb9d3ed9875c63227140"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.1/anda-linux-arm64", using: :nounzip
      sha256 "e2d50b56ac882812cff3fd82b9ca647fc1ec83787999edad166bd90facdd604b"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.1/anda-linux-x86_64", using: :nounzip
      sha256 "9ed9a86264b0e0304d72aa07b5ec1afc30bde15cfa2f25db9c76f12feecf4ccc"
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
