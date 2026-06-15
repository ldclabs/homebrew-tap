class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.5/cbor-macos-arm64", using: :nounzip
      sha256 "17928405bc8994c5c1990b5216808491c38ab836d99251d2203ba7c51040b686"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.5/cbor-macos-x86_64", using: :nounzip
      sha256 "523423904acfba8a1bb24d77b64be4253cb43f53a57c0d582e7e953cfc8aacf9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.5/cbor-linux-arm64", using: :nounzip
      sha256 "c6aa25e3c960a12bd0a68219254364c000b750d705fd3e2fe0f8e7a855d926a4"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.5/cbor-linux-x86_64", using: :nounzip
      sha256 "92acf41efeae2a7e1afdd89666f84245fc929d7e67718c6a358ac9f59bed4aa3"
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
