class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.6/anda-macos-arm64", using: :nounzip
      sha256 "12bd9ae82dbc1458fc4060f9b6ca9cc4aa2231eb4be3328c3e11ba59328b74a8"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.6/anda_launcher-macos-arm64", using: :nounzip
        sha256 "0a2d292cdd3d28acbfe224388c50a8155234090489e72a4275d298b16e946ebb"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.6/anda-macos-x86_64", using: :nounzip
      sha256 "6516a15fab7e73489480e56f1eacf2ef19d55ced43f0f88d6cdb50f8b584fa94"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.6/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "2fe7c2d58c37817caa2a5e6eccfb3432d2a1bc051d452e6acacb10d31fc90cb8"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.6/anda-linux-arm64", using: :nounzip
      sha256 "93fe8e9d25575dbba18597f328d2c75df7bae09224a7494ffdf32db04e154ff8"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.6/anda-linux-x86_64", using: :nounzip
      sha256 "42390f0d9e7e85f52b1c5ae4e8b27bcd6e81744b2c04d41b2a721ee56a14bccb"
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
