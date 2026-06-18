class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.16"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.16/anda-macos-arm64", using: :nounzip
      sha256 "25cefe4498c37021026d3c61dd1f02fac8c8f316b623d03342ba8cdddca4a016"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.16/anda_launcher-macos-arm64", using: :nounzip
        sha256 "7f0351c06e99e128c425810c3862aa448838c9d7b81ec1266f41f4eb2ac42928"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.16/anda-macos-x86_64", using: :nounzip
      sha256 "d908458cbb2175afdcf82676f28766a980da6c383cfc50156faa1bbfd64ea26b"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.16/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "88fa6c4b03c368dd60053ba4f4e6c947abb2de6b3becd2eb359559d41ea8d889"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.16/anda-linux-arm64", using: :nounzip
      sha256 "7a809a708df22775c842ce882a2a8722ba946bf849b160fb2cf5fc8ccc7a93a9"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.16/anda-linux-x86_64", using: :nounzip
      sha256 "964d69c0e58adc464e8eaff144f0b0578d6945994f692ff0e8128eca06bcaa4e"
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
