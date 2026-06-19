class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.10.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.0/anda-macos-arm64", using: :nounzip
      sha256 "a2289be9bc08027f61d25d7dc9c2f2a020519fa8a4d4ef9f0d19fa51f9846016"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.0/anda_launcher-macos-arm64", using: :nounzip
        sha256 "38e7a1acc0014800f2dbc25bf0ba5f3f72d606561cc05d24cb2642ab3325b56a"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.0/anda-macos-x86_64", using: :nounzip
      sha256 "967a3a0d55992d40fc2fe1a9782fcafc9d1fe6add7df9df14f5dd69cc1ee6d4e"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.0/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "c290d6f6dd23c7720230930c1808c928972d5a44ad1d82031dec2db4488fea2a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.0/anda-linux-arm64", using: :nounzip
      sha256 "608a045a4365cbb697ecb4dbb49f4cfe7d490fe2699f64e9e57e6a056919500c"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.10.0/anda-linux-x86_64", using: :nounzip
      sha256 "5eb8c4718b5b709bcd36ffa61128e952b47929edcc7166864017fc63c0c668b0"
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
