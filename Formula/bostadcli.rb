class Bostadcli < Formula
  desc "CLI for fetching apartments from bostad.stockholm.se"
  homepage "https://github.com/Coriakin/bostadscli"
  version "0.1.4"

  on_macos do
    on_arm do
      url "https://github.com/Coriakin/bostadscli/releases/download/v0.1.4/bostadcli_0.1.4_macos_arm64.tar.gz"
      sha256 "d8fde4c3583c112a4d59a7c9629500f5c6092b2a6a1988692182c04594fea668"
    end
  end

  def install
    bin.install "bostad"
  end

  test do
    output = shell_output("#{bin}/bostad --help")
    assert_match "Usage:", output
  end
end
