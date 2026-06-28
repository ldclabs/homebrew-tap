class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.11.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.2/anda-macos-arm64", using: :nounzip
      sha256 "07c2f34899c14f52d80ce216e2132dd630e2f9c9b55be2d3dba6699d1316e0aa"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.2/anda_launcher-macos-arm64", using: :nounzip
        sha256 "609e31dff6f6a2aaa55b71bd31efcc2883351ebd2d4fed6edc4463f1227a9975"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.2/anda-macos-x86_64", using: :nounzip
      sha256 "1be926cc054a75eb09f9598f59d7e20a66923e3dff97feda83fa3f9d4634091b"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.2/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "1741da10f293647d712dbdedde93f717021c2f2f36bcb0b937497f9c0f8174cf"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.2/anda-linux-arm64", using: :nounzip
      sha256 "68c6a2b9ba8c5a1596261a7d684803d3083bfbe4d8ae36fefa34a8c0addecb91"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.2/anda-linux-x86_64", using: :nounzip
      sha256 "6f04d62517441d2ecbc9a55c03fe21b211e13a8d8eeb0996c2ed9eeee5ff93ba"
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
