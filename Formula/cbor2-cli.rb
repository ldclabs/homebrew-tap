class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.1/cbor-macos-arm64", using: :nounzip
      sha256 "3f07d704ccac34e3a572f6bdbfeb013105b4e9f8f73d8ee22eaae911f6b42812"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.1/cbor-macos-x86_64", using: :nounzip
      sha256 "192b8a74e5c0a96135fb222f08883db9445e1f59180ab6b8a764a75c582e70ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.1/cbor-linux-arm64", using: :nounzip
      sha256 "2be9d8fb31474ec0d3de4fb23032127750f8a34694da507b0ecd80a119cfadd6"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.1/cbor-linux-x86_64", using: :nounzip
      sha256 "9b3f95f2b2ba79158ca618fedbcd63fc1d986928a45c37aa270cd18b0499742d"
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
