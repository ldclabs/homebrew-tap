class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.10.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.4/anda-macos-arm64", using: :nounzip
      sha256 "8501e792b815aefffd3311ace1f04ea83b6dbdbda5c26da43534846d1e9ba01f"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.4/anda_launcher-macos-arm64", using: :nounzip
        sha256 "1fd8954aa44bf5b5c9243fc307cd0a497bb96a2ab29e092c6ac6e37cf158649d"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.4/anda-macos-x86_64", using: :nounzip
      sha256 "a861667db6c88f9c2bc246c3dc81378c14b5a31e79386df6e8d8476d67c36958"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.4/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "f2c80ebcaabc9a60dcc0a2f65cc98ebab8823f5351f9572a0ee34ddfbb4278a1"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.4/anda-linux-arm64", using: :nounzip
      sha256 "2206105fb2715686ed5264706993778380d983f8609a85403cc53e6bc2699e05"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.4/anda-linux-x86_64", using: :nounzip
      sha256 "3082891c7a31e4f9fe4e91e7c1f2c219765dc00dd6703a0105cd3cfc246ae6af"
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
