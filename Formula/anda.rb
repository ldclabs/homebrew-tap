class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.10.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.2/anda-macos-arm64", using: :nounzip
      sha256 "ad53b2473351ae2c0b41e54effedfd313ab70c25b4c131eb1804d79f0da975b3"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.2/anda_launcher-macos-arm64", using: :nounzip
        sha256 "99bbf46fe7371b26ff0bfc96bd5395b16ebc3285b5f031aeb81e09ca6d19f51f"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.2/anda-macos-x86_64", using: :nounzip
      sha256 "32bf5500dda9871a05541dff275cdab381fc452c885fe4c88e86398e27ed2e1a"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.2/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "47a1d9a09d98b3c1788da136affed010e491e62ac0799af5a35f4c3b0cb63124"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.2/anda-linux-arm64", using: :nounzip
      sha256 "debea78da9c5dd15cafb48fc254ebe911d74cea720d622c5f517103167a0e74e"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.2/anda-linux-x86_64", using: :nounzip
      sha256 "7d7cc65c4d7832f045001ac8f93cac371eafde5182a11422b8bdd9622715ac2d"
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
        "The macOS formula also installs the menu bar launcher:",
        "  anda_launcher",
        "Run it once to create or refresh ~/Applications/Anda Bot.app.",
      ]
    end

    lines.join("\n")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
    assert_path_exists bin/"anda_launcher" if OS.mac?
  end
end
