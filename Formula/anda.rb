class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.10.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.6/anda-macos-arm64", using: :nounzip
      sha256 "c875359bed70efcb16cac8aebb05b10e32a00e28c6805d8156670dbe3a46ca40"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.6/anda_launcher-macos-arm64", using: :nounzip
        sha256 "d92948eedad74a2151336de7e15cd9646901fc5b0b92dfb9b7a2ace57d102d0e"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.6/anda-macos-x86_64", using: :nounzip
      sha256 "2d4276f3e8e3d48f1f4a27d1e9f8c67536aa208ccda05194ef0fbe1670af81f2"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.6/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "fec42088bc02f1d14c0e57de3e03dc8403b79b638ae302542230105213626f41"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.6/anda-linux-arm64", using: :nounzip
      sha256 "19a277867ca85ff1037a5c90ed7aec666b86b62da3fdc5dedad12339f7e5a38d"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.6/anda-linux-x86_64", using: :nounzip
      sha256 "f278209a2f40feb93bb62cc77b1d8b5fdce1df286b4e396a2c216225dbac9e4c"
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
