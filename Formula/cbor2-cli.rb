class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.2/cbor-macos-arm64", using: :nounzip
      sha256 "05d79784a0d252cc9afbf0cfb81a95a8d22e008f04faae09a0503e8a38480278"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.2/cbor-macos-x86_64", using: :nounzip
      sha256 "abfacc488bf37ad82890d8af2dd2ecc90c6644d00b6386df3634dd0e91674f92"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.2/cbor-linux-arm64", using: :nounzip
      sha256 "c172060c3b2a89b310d505759d49584fb0993ec4df9912459df1f4ddbbb653d4"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.2/cbor-linux-x86_64", using: :nounzip
      sha256 "9ee764f9db13adc76e40904ae206afc3d61c6ccd8d05da304dde92e9c0371e78"
    end
  end

  def install
    binary = Dir["cbor-*"].first
    chmod 0755, binary
    bin.install binary => "cbor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cbor --version")
    assert_match "{1: 2}", shell_output("#{bin}/cbor a10102")
  end
end
