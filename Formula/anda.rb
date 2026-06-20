class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.10.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.1/anda-macos-arm64", using: :nounzip
      sha256 "c729dc6808d27ce3ab2f3b8f6dbd5440300428eb7c0d5fabd493f1c35b6ad2ea"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.1/anda_launcher-macos-arm64", using: :nounzip
        sha256 "1b56d8cf8e5cbb5ed62cefb6cfe9188869de85ceeef03d503ecdf6250d4c1fcb"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.1/anda-macos-x86_64", using: :nounzip
      sha256 "7b53e38142a0ecca506257ad58d6037445c8adef50fd7296ee13a3ab6f4733d9"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.1/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "e817d0800245a0ffd4bcde10b275016e8c042f9a2fb1351238e6ecddd9ac35a7"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.1/anda-linux-arm64", using: :nounzip
      sha256 "35da476332fa4f5751e7d810078e9824235614ae8ffbcb09b879ce1dd8fbd69a"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.1/anda-linux-x86_64", using: :nounzip
      sha256 "ee8c00b44c6bc5cf40d301a109c28eeeef2aafde91a58e82952ac0348dbabbdf"
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
