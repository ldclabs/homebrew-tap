class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.7/anda-macos-arm64", using: :nounzip
      sha256 "9632e14f7913e2ef470735780fd60d62362a8befab33f1db3f683be89eac19a2"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.7/anda_launcher-macos-arm64", using: :nounzip
        sha256 "535795873b6b8dc80803a46bc194a481c7dbc4c9379fb103e194bb4ec0080ba0"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.7/anda-macos-x86_64", using: :nounzip
      sha256 "cd71aa44edff3d8c1faddadb5c9114b604f5b33509fb10c1cb00e2b2ab91be80"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.7/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "b2767ba599e65d7d14611bc637a409373fb2e154818c300f068585b9c75164b6"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.7/anda-linux-arm64", using: :nounzip
      sha256 "f6f2cfd50434f270e33dc7a7b96545e2dbba679feebb9e9f4a17648bf5925d7c"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.7/anda-linux-x86_64", using: :nounzip
      sha256 "a8150e3faae757844d83d6d2ca1971513045d6b71e736688a9eb1a4ec5e99e36"
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
