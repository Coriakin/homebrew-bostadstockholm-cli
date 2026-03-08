class BostadstockholmCli < Formula
  desc "CLI for fetching apartments from bostad.stockholm.se"
  homepage "https://github.com/Coriakin/bostadstockholm-cli"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://github.com/Coriakin/bostadstockholm-cli/releases/download/v0.1.5/bostadstockholm_0.1.5_macos_arm64.tar.gz"
      sha256 "7e389d61da890f343d8bf366e5a67d5dabb897ebe4c18f1c75f53252d87d3ddc"
    end
  end

  def install
    bin.install "bostadstockholm"
  end

  test do
    output = shell_output("#{bin}/bostadstockholm --help")
    assert_match "Usage:", output
  end
end
