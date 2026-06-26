class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.0/cbor-macos-arm64", using: :nounzip
      sha256 "52f8ad7d236f03e9fbc75a300c41dc61593c715478d423e3e3d48c86a259deb0"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.0/cbor-macos-x86_64", using: :nounzip
      sha256 "6b382efc31a233a02670356a0379cddbd937bca8cbad1a02e7c507247e9cc079"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.0/cbor-linux-arm64", using: :nounzip
      sha256 "591c390951effdc221a7d84a5698b54032c0116ca8b5d1a54dafddc71f1ccbf4"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.0/cbor-linux-x86_64", using: :nounzip
      sha256 "8f0116a82909e8fe3affde485a574ad2ba637e53f5179ad8d24578a30874d970"
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
