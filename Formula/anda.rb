class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.6/anda-macos-arm64", using: :nounzip
      sha256 "bd840d2b8876fd868b8d906ad9af958ff7f74de7c49488a4b506458f4a59391c"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.6/anda_launcher-macos-arm64", using: :nounzip
        sha256 "aa8c79f724a7d14baab1613404aba04a601f1ffadc1c1fba0fa29350ef1af594"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.6/anda-macos-x86_64", using: :nounzip
      sha256 "5e70662e7741548e4ffc28d3d69612f4bdd87cb7d69bec7ad2c4c6d134ca916f"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.6/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "126e5fc9f4c49f3263af53a06af8cf96aa0bf539e59d9e573cb1f7cb76c6bf4c"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.6/anda-linux-arm64", using: :nounzip
      sha256 "5b5b6817a466f5b306691b67297fd9ac5ec6b5baa3fb4862395e881c91363b68"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.6/anda-linux-x86_64", using: :nounzip
      sha256 "96a633d7c0c42769f61524d100e400b41a780d3c345c4d79a6e232f89be7cec3"
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
