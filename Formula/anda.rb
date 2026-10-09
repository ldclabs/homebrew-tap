class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.4/anda-macos-arm64", using: :nounzip
  sha256 "f13c78451c4318f4d8e625e2c5ee23d9dadb20de4653d4c6d57f0a919f657572"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.4/anda_launcher-macos-arm64", using: :nounzip
      sha256 "3e986ba528e4de43a6e820399d85f60cb19e8e7e671c67bdf760adbe2bc5897d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.4/anda-linux-arm64", using: :nounzip
      sha256 "13c4f925263968ffa59c4ef6e0b8e064516b2c63679462dee3b3e0b1d050a861"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.4/anda-linux-x86_64", using: :nounzip
      sha256 "9b05f50c003c4b2d8085a37562ae7611b32c2bf92a9a170482040e3f4c096aa8"
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
