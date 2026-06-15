class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.11"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.11/anda-macos-arm64", using: :nounzip
      sha256 "2bae6bb8220b87a2405cc18622ffb2687bbeb9a92067bef5a5a4607aa0dcec7f"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.11/anda_launcher-macos-arm64", using: :nounzip
        sha256 "40b3bed69a4961db9ce48d201a7c628d34d7e73f5c81094b1e88294a6503a518"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.11/anda-macos-x86_64", using: :nounzip
      sha256 "c69b87f490d7f73715351bfd81699abb0d472ecf0c813ea762c14aba52fe07d1"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.11/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "e356e8748a87555ee430199950ebe8368e117160194a47150333651a3685b230"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.11/anda-linux-arm64", using: :nounzip
      sha256 "c13aa3a86e227f94a833147b96f5fb44ce0d665abd70c9ccd21027db49afba61"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.11/anda-linux-x86_64", using: :nounzip
      sha256 "65408d1863b7273e877687ffca8a0d8fb5bc4bf732e2aefc477e1235653393de"
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
