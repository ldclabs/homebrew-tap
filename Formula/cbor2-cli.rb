class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.4/cbor-macos-arm64", using: :nounzip
      sha256 "187bdc0ace1d4d8d5754985f77eaff577bc068ee63f743e7c0152627326a105c"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.4/cbor-macos-x86_64", using: :nounzip
      sha256 "88b442c8a3455010ff681dcbd19037cc167b6a433e34b39cf182b17a2b3771d4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.4/cbor-linux-arm64", using: :nounzip
      sha256 "d7fb57f7a65b66f5cca37edd554d3f72271319be4d98fc11947e583eaf1cf67b"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.4/cbor-linux-x86_64", using: :nounzip
      sha256 "0b989c6d73bbff6d7ff8f580c7c615331bbab739b36f6bef7c6e841e5c116dc5"
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
