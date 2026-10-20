class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.6/anda-macos-arm64", using: :nounzip
  sha256 "532f23685212523c6f3f62270a8a2d0120671a674f0cd427210afdcf9aa74ce9"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.6/anda_launcher-macos-arm64", using: :nounzip
      sha256 "d3ea77527405aa73ab944bcad252ebf7d65254f0193cbb916db53f57d9f48532"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.6/anda-linux-arm64", using: :nounzip
      sha256 "b03ceb1d8f459ee43bb4ef53e4f00e56e74f44b5b606979c8d1eaa29ed478b8c"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.6/anda-linux-x86_64", using: :nounzip
      sha256 "6ac832baeea779adc1bc41fff6d0be74f6df2c5e20d94ac78788f84519b1c276"
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
