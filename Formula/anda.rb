class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.3/anda-macos-arm64", using: :nounzip
      sha256 "453f5c50e1c6b5c2dd6833bf1fdced345db1bc090f4fc86e9672d1ede01b2547"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.3/anda_launcher-macos-arm64", using: :nounzip
        sha256 "856c7684c4e53df5c9e3bb6d2d3afe97459fb280b713de717243eae496e706ec"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.3/anda-macos-x86_64", using: :nounzip
      sha256 "4054c02d7f0bedc88e05db96ce8d5d142419722f3661fc1ec6e540c06f0807ec"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.3/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "2ae544e20dc37d9c491b5e345b35b14d958d55ad955c457a9d6236228b499ce6"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.3/anda-linux-arm64", using: :nounzip
      sha256 "a5eceed00990182e4d32033806f8a265c21b9d2acd093abbd21130acaace5e59"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.3/anda-linux-x86_64", using: :nounzip
      sha256 "9dd21edc2fc213e1a7a56cd649ff7862993e257d1c3a51f5b71dffa5b16c99c6"
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
