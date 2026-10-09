class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.5/anda-macos-arm64", using: :nounzip
  sha256 "83ddc8f7d737d167768b70b01bcd0157c6473922bc84c3323eb1b78c0eb14c4a"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.5/anda_launcher-macos-arm64", using: :nounzip
      sha256 "c8413d695a654e72c7e46407a0a6283542a578819ec476d7083ab067249e8087"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.5/anda-linux-arm64", using: :nounzip
      sha256 "e8f4d8f7c6e15ca4992627ba99e217ba49286621f8e314530cd34afbdb794f07"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.5/anda-linux-x86_64", using: :nounzip
      sha256 "6c8e7a065c026154a8d47be848f6f6f566dd1aa2a8cd10bb77bcf547568ab0ea"
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
