class Bostadcli < Formula
  desc "CLI for fetching apartments from bostad.stockholm.se"
  homepage "https://github.com/Coriakin/bostadscli"
  version "0.1.2"

  on_macos do
    on_arm do
      url "https://github.com/Coriakin/bostadscli/releases/download/v0.1.2/bostadcli_0.1.2_macos_arm64.tar.gz"
      sha256 "87e9988111591e7d96b644dadfa4fa92c4b9e2fc1591752a553732804ee2f74d"
    end

    on_intel do
      url "https://github.com/Coriakin/bostadscli/releases/download/v0.1.2/bostadcli_0.1.2_macos_x64.tar.gz"
      sha256 "f30dadad9faa7bb093cf8ba77986b96985c55abccdf7b57b8e47e7a3a1ce5d86"
    end
  end

  def install
    bin.install "bostad" => "bostadcli"
  end

  test do
    output = shell_output("#{bin}/bostadcli --help")
    assert_match "Usage:", output
  end
end
