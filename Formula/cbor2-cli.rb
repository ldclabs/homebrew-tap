class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.0.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.6/cbor-macos-arm64", using: :nounzip
      sha256 "ac87615eed652bc93ee0552dde2c18a532788d220b492a973c6ca58261a6c20c"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.6/cbor-macos-x86_64", using: :nounzip
      sha256 "f3a716618270504491344599a055e7c0494558609857ca2554ebd5a6834fa321"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.6/cbor-linux-arm64", using: :nounzip
      sha256 "0d51de246926d6f5f0ed7ac8c33e02534fe55c36c2205415fe9dedd435ea0955"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.6/cbor-linux-x86_64", using: :nounzip
      sha256 "dd2ac7a472a88a41c5a56aa5e6e1844aa2959b5a872d8427ca1115c1bc7730d5"
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
