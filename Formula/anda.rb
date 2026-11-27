class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.1/anda-macos-arm64", using: :nounzip
  sha256 "e516e44546ba39176d2a7ac2da30b56fece7912ba160f4bcfdc0c395163a6582"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.1/anda_launcher-macos-arm64", using: :nounzip
      sha256 "a51732c269a9036496aa60a184042c0dd0e8cfdfc3961e9ccba44eae60b5dd71"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.1/anda-linux-arm64", using: :nounzip
      sha256 "f12cefa093a76fced051f038bbd061be339bc2c3c23876c05b6b1dc4a94aa3cd"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.1/anda-linux-x86_64", using: :nounzip
      sha256 "edd48e3c75457c2eb1c7501b546f9ad54a59f3d6d446d8c5a7d9b6c6cbbf02b0"
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
