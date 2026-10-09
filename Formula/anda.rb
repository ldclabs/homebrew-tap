class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.6/anda-macos-arm64", using: :nounzip
  sha256 "cccff4d1f5b1aa9f661dd65a147d14702bf30c14a61a603a2128b98d4220e52a"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.6/anda_launcher-macos-arm64", using: :nounzip
      sha256 "d5508c05fd1af5421a3be3a9f6c4dd04a88467698bed7f3372f9e4d71fb18a49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.6/anda-linux-arm64", using: :nounzip
      sha256 "c4a3f972fe7696e36a72b5476d555365989cb51f9db7b11cd78aa7f5f64da38e"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.6/anda-linux-x86_64", using: :nounzip
      sha256 "a10f827e1c15873f4abbd2c2b8a98283e249a618eace47598a5e1d9a17338033"
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
