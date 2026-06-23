class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.10.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.5/anda-macos-arm64", using: :nounzip
      sha256 "78ef6bf5143067ded5ae373014c1af340473b8909b671212cdb6372123212274"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.5/anda_launcher-macos-arm64", using: :nounzip
        sha256 "32f9b5ed398777223293e735e80aa0395a55cf0f99fdcf19ee639e6697f91bec"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.5/anda-macos-x86_64", using: :nounzip
      sha256 "209ebf4dadd35e3d7a5bfa7abc63aea63b74b54a33e71f123eb3cd25c7b310b6"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.5/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "15123e55a251ff00a4e465a52c1d2eab7b46127634f22c2006c230da56df8c71"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.5/anda-linux-arm64", using: :nounzip
      sha256 "f88e436c7d42fb5d302d7b18899b7499e1f608f41b8c73039260a97f3bbd3838"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.5/anda-linux-x86_64", using: :nounzip
      sha256 "4a6b269d531fa6a04508fa570106c82db16d5fe2a756d76c8e1914760f2b75ed"
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
