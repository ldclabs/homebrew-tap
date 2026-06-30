class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.11.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.3/anda-macos-arm64", using: :nounzip
      sha256 "ab0f01714f930b926b775ed0ddb57dbc411e88a1acba44784f244aeb39f6b05e"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.3/anda_launcher-macos-arm64", using: :nounzip
        sha256 "ed10593ffa374f015575a399d806a0bb583c330a3e0e6adff82cb654eaf870b0"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.3/anda-macos-x86_64", using: :nounzip
      sha256 "b33a7e53a006272774bc07e00890b3dc6b5cfb198edf2b6a1ffe7a80cdc07730"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.3/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "7b570fcbc9b5939d8c89e412fb76b2d56ec00a346f0e2379b67bb6519a5dac5f"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.3/anda-linux-arm64", using: :nounzip
      sha256 "f1373a99d3fd4b1ba04bccec4075044b683b321aa30d7425196531599d7898ae"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.3/anda-linux-x86_64", using: :nounzip
      sha256 "7a12240347142fd01688f2e816611a557f5ab7b854f347d310964f4460e864ad"
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
