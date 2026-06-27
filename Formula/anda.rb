class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.11.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.1/anda-macos-arm64", using: :nounzip
      sha256 "bc8d57ad010cb3f7e696520eff7897fd60a35abf4087c1ae3a46701750b52f00"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.1/anda_launcher-macos-arm64", using: :nounzip
        sha256 "a6da1420658a72e060efe72ac0f3befde04ab04e2c0dca63d1fef7b1ece1a218"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.1/anda-macos-x86_64", using: :nounzip
      sha256 "2e3674656c73c59556d7bab4309ee8b8513b690c80a1bcdab96fe682ca7c6ca7"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.1/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "bbe5a8c77a80f44a82065371da2780514defb48b602640c430591e1a81125ce7"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.1/anda-linux-arm64", using: :nounzip
      sha256 "e1443edfb81b2a281a25f886f5201eed4b025117e6ace1a50eff5e033e0f45d5"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.1/anda-linux-x86_64", using: :nounzip
      sha256 "c308606769f3c2d0f3e4075d545e0de6c599fe0abb57fda3fd0ee2c8a8a171c1"
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
