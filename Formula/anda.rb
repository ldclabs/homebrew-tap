class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.8/anda-macos-arm64", using: :nounzip
  sha256 "fabfd852acb7c479681ef3fed8be709f50c2188a4bc2a3f816013a9a127f72cb"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.8/anda_launcher-macos-arm64", using: :nounzip
      sha256 "1e38f0a994fcc4b9991f1695ca8c0ffc15ec9ea99e39ec63354f8a5bd20212fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.8/anda-linux-arm64", using: :nounzip
      sha256 "731552e2389fbc5251005e753a1b42f0ec79e8150d959b4f72fd28ece5ad8e6d"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.8/anda-linux-x86_64", using: :nounzip
      sha256 "8d002b7bce9edc83dd8a9c2df653a05c2c0035babb0555537e256390d6dfd11d"
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
