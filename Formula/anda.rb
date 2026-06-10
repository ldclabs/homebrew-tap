class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.5/anda-macos-arm64", using: :nounzip
      sha256 "0d01fa1da0f21f2d06741afebb5cd234af19cf245438a4842a6d9a396be54f3a"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.5/anda_launcher-macos-arm64", using: :nounzip
        sha256 "30872b0fc98e79e80609a16e57c8a6ddbd55c07cb3c99e67fd8ac5405fc0ba21"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.5/anda-macos-x86_64", using: :nounzip
      sha256 "e07ea59d3940a6ee2da3ad21586c858a126b55aef5e71b9a50f97504edb5b659"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.5/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "9f2bd6a9f1c10c14af308e7148800a31427c1f7612f0784e35b9e8665a6ded42"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.5/anda-linux-arm64", using: :nounzip
      sha256 "f91608367c6d3249af69174825d152fc555f4f6855c9ea594dd50ab80cec8986"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.5/anda-linux-x86_64", using: :nounzip
      sha256 "07a3da55e1a047df8dfb9b39ff2b3ac88d054de30531b65f451fe6a83032eb4d"
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
    assert (bin/"anda_launcher").exist? if OS.mac?
  end
end
