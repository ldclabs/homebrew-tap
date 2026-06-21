class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.10.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.3/anda-macos-arm64", using: :nounzip
      sha256 "e67fd887b7966fe0be0e126b6cf673eb0f4b6972dd97f50f34e8e6242d41cf24"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.3/anda_launcher-macos-arm64", using: :nounzip
        sha256 "6c5e5199d10e6ed82a4c128b636c8c30411068cf74f526898d141ead2dcbaa9a"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.3/anda-macos-x86_64", using: :nounzip
      sha256 "29765b818cb55e8c6ba28e9d038d599fa0f4a04ca20f55cc9cf6f6930e1b7e0c"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.3/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "60710de9da4f5a474b4ec093081f9597758c4442ea6390b24b4ca4c877c0be1e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.3/anda-linux-arm64", using: :nounzip
      sha256 "8ae7a041a4e3b69c283033861209cd489fb605d84baf0a9e8d26ea0d4a73c96b"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.3/anda-linux-x86_64", using: :nounzip
      sha256 "f893c981300972514104d8f28e4fba08c840ea6ade330ef8566e773d8b093afc"
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
