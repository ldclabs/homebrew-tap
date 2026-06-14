class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.10/anda-macos-arm64", using: :nounzip
      sha256 "5050da28e7753ec19176fde8306cf28bb9e8d93d1e3e21a5c32fbf96db5e5888"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.10/anda_launcher-macos-arm64", using: :nounzip
        sha256 "24f5b1ed3632643bf5e12f11df0a686878d204d96ba3bea16c5364db5ca9169f"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.10/anda-macos-x86_64", using: :nounzip
      sha256 "a0583179a797af37ab6d223f657a3e2ec87eae1c268717190c66a427f8f1ca51"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.10/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "ed07db2a6f9604337eba670cb0ae6d624e0f7714cb07887906bf708ac7b08efb"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.10/anda-linux-arm64", using: :nounzip
      sha256 "44e7cdf051cc4535a3718a72596c6e446be766df9d2b17f7c478cdd3c1941838"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.10/anda-linux-x86_64", using: :nounzip
      sha256 "ab4d41c034b333548b43462e24910e12bfde8ba36c08ce8d132b91f529ea2622"
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
