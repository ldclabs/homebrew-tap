class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.12"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.12/anda-macos-arm64", using: :nounzip
      sha256 "f4bf619e4b9877574bfd3962b483bf368b2c75bd51a659beab11a2da8d82cbc2"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.12/anda_launcher-macos-arm64", using: :nounzip
        sha256 "6dcbc322aa772540f8ae4de6f7392fca56a101b0a266e3ddd456079c6e772ab0"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.12/anda-macos-x86_64", using: :nounzip
      sha256 "dc8b2f8aa79eb8a8bdaa4a3485fc15ea8aae422836523365c09be254a61848fd"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.12/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "017b877d7e2d84f79e7cb00d46dc85273a010e64fa437d84ab8e5a74aa6005d2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.12/anda-linux-arm64", using: :nounzip
      sha256 "2ab7b92249b6e7844b4191278aba486df0aeaea6afbef2c47c3c05845ac33d4b"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.12/anda-linux-x86_64", using: :nounzip
      sha256 "c7f676a43d469e219f6a2287fd48db84dfac0274d5993b67b148772d8a08a419"
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
