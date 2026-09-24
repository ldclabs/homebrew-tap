class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.6/cbor-macos-arm64", using: :nounzip
      sha256 "2e5ccbceebaa8bf9e67add8ce1541d11af478fe9ffe62afc44dfd3af4dbf91b8"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.6/cbor-macos-x86_64", using: :nounzip
      sha256 "a4ac347f85d20d794d5a7d3136fcb473a467e8218d91425999cdcdee8799499a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.6/cbor-linux-arm64", using: :nounzip
      sha256 "f80fc9f9939d97935b629202a2c0235e1208adb5a92bf529dbf9e5f10c1b909a"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.6/cbor-linux-x86_64", using: :nounzip
      sha256 "f9198e6283bf8347f4cfd259ad03cc2d90c193e194e7ec72affa978ec9822763"
    end
  end

  def install
    binary = Dir["cbor-*"].first
    chmod 0755, binary
    bin.install binary => "cbor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cbor --version")
    assert_match(/\{\s+1: 2\s+\}/, shell_output("#{bin}/cbor a10102"))
  end
end
