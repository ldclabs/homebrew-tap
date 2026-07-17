class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.11.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.5/anda-macos-arm64", using: :nounzip
      sha256 "178d249cc640dc76467e6af2118081842be3819e5bf329dde893e185335bfa99"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.5/anda_launcher-macos-arm64", using: :nounzip
        sha256 "0ab0dfb9ee3b903f7b1ee2ecb8f2670d1bd906b767a62bc6c4b47642cff7037c"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.5/anda-macos-x86_64", using: :nounzip
      sha256 "68299aaec9ae8b93466b4a8d945bc0add57a3f25d708fdc99057c2900aacc93f"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.5/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "b78672548cac13ce4342fe117718d610eae8fb091ad56e9d7ef13f3fc64afb5e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.5/anda-linux-arm64", using: :nounzip
      sha256 "b9d9f4311b56c378064509ee0df809b77ed3026f817ebd102d155d88be321bb6"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.5/anda-linux-x86_64", using: :nounzip
      sha256 "d931e36cfedcfcb11afddbe105e39e06c8ea360ca1dc3282eabdf6e2b256f67d"
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
