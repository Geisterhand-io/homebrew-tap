class Geisterhand < Formula
  desc "macOS screen automation tool with HTTP API and CLI"
  homepage "https://github.com/geisterhand-io/macos"
  url "https://github.com/geisterhand-io/macos/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "14f62140e48eab66619cec1a8450fc8aecd7682e11c50b4da81ba6c501ede571"
  license "MIT"
  head "https://github.com/geisterhand-io/macos.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on :macos => :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/geisterhand"
  end

  def caveats
    <<~EOS
      This formula installs only the CLI tool.
      For the menu bar app, use:
        brew install --cask geisterhand-io/tap/geisterhand

      Geisterhand requires the following permissions:

      1. Accessibility: System Settings > Privacy & Security > Accessibility
         Add your terminal app to allow keyboard/mouse control

      2. Screen Recording: System Settings > Privacy & Security > Screen Recording
         Add your terminal app to allow screenshots

      Quick test:
        geisterhand status
        geisterhand screenshot -o test.png
    EOS
  end

  test do
    # Basic test that the binary runs
    assert_match "Geisterhand", shell_output("#{bin}/geisterhand --help")
  end
end
