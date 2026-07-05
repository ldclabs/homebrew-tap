class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.11.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.4/anda-macos-arm64", using: :nounzip
      sha256 "d8f8c977d130c4fcc91b034b1a7d7700de238b71a87a65d60bb4ba289ba45577"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.4/anda_launcher-macos-arm64", using: :nounzip
        sha256 "8f8ba68dd321b7afeb89798cdacd6ba271aecdc4fb29e8afe67f627c987f819d"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.4/anda-macos-x86_64", using: :nounzip
      sha256 "8f09ff77b9eed9676dfcd4068a5417c13068eb313d7cb38b971f42c746642537"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.4/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "f72ed9f430f63b8ab6efed2f6d7213b39ecbc5402cc24976856e85335768b4f5"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.4/anda-linux-arm64", using: :nounzip
      sha256 "609f762653de3c203261ceae729839e526c1dfb76272694a73b29cf5d296882c"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.4/anda-linux-x86_64", using: :nounzip
      sha256 "a667c1af6817267034f85ec4049b5c460052da9a15bdb178d358bedcb6c523b5"
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
