class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.13"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.13/anda-macos-arm64", using: :nounzip
      sha256 "a9175f5a752d8782c23fafbf68917bfe5d07ae90d02dff260beb276a5efa084c"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.13/anda_launcher-macos-arm64", using: :nounzip
        sha256 "a79a821455086b6ae19695125d3a4a454e0352a5403202e885757a68ea701e93"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.13/anda-macos-x86_64", using: :nounzip
      sha256 "146d95502392f2a3aa7e7ff57236e37b8550e64c659b1b4fdbd8546d478e2bab"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.13/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "a319612b1ba7aea061e1833aedd8940c1e1ac45fef1d49567ab6a3403bd8ab63"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.13/anda-linux-arm64", using: :nounzip
      sha256 "60265bb88be108a5a23bc05c0b78df5d9765701ca254cf205926392b9527af1f"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.13/anda-linux-x86_64", using: :nounzip
      sha256 "877a41eb686610dc686479434fbaef1fbcc10905f121b580511f251ab5003bf6"
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
