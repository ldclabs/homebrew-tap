class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.8.10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.10/anda-macos-arm64", using: :nounzip
      sha256 "aed878b3ff20177687098125a445d7a8a0717c9fb6ae6cd54a0fffb158772b10"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.10/anda-macos-x86_64", using: :nounzip
      sha256 "cd9e0b4f0a4819e4c2b9d099705f702958482a4f6c432e7db06828187fa95b38"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.10/anda-linux-arm64", using: :nounzip
      sha256 "7c556e9e19c8e638e129aceb33ec456bcaa63b7d4830e075386ac44dfaf81b1f"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.8.10/anda-linux-x86_64", using: :nounzip
      sha256 "44b7f66db803ada053d71e7927a4f5c401b6f79efd77834bdf8e3fe186ec0514"
    end
  end

  def install
    binary = Dir["anda-*"].first
    chmod 0755, binary
    bin.install binary => "anda"
  end

  def caveats
    <<~EOS
      Homebrew does not write runtime files into ~/.anda during install.
      To install or refresh curated skills, run:
        anda update --skills
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
  end
end
