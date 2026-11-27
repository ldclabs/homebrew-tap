class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.0/anda-macos-arm64", using: :nounzip
  sha256 "cd013b2f5aad341280763d54f8555b98fb005dd7cf4903f12febd629a5564f55"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.0/anda_launcher-macos-arm64", using: :nounzip
      sha256 "3a7b8db28ec1cba849dfc5924830e5fa47e14f306f5e841126485ec9ea9a85ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.0/anda-linux-arm64", using: :nounzip
      sha256 "f8c8825ceef8bfc880bca9537c9983046004029df5ab1661c5f5b666807a14b3"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.16.0/anda-linux-x86_64", using: :nounzip
      sha256 "6de052d2e6cd698af93ab8c9239ffc3042d34e4c1f70561bc65ae7dde0a33344"
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
        "The tray, chat window and settings are in Anda Desktop, which uses this anda:",
        "  brew install --cask ldclabs/tap/anda-desktop",
        "anda_launcher only retires the old Anda Bot menu bar launcher and will be removed.",
      ]
    end

    lines.join("\n")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
    assert_path_exists bin/"anda_launcher" if OS.mac?
  end
end
