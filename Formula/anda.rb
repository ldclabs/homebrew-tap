class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.0/anda-macos-arm64", using: :nounzip
  sha256 "dd4ca6b18392fae94f93a768e41fa275783eb1ca088c6b80da5f47bd9076bb2a"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.0/anda_launcher-macos-arm64", using: :nounzip
      sha256 "22db11f01087e8f8b777511394ee6ddd54c665ee663d81760b0cc00edb29ecb6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.0/anda-linux-arm64", using: :nounzip
      sha256 "3f4a964e789974a2989c06641b8e6c82bfb314fb3291ac5b501bdb6930fbff70"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.0/anda-linux-x86_64", using: :nounzip
      sha256 "11fde69277def1e7e9abbf311450b2e36240d248dd613f118fac88eadaf3ceb2"
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
