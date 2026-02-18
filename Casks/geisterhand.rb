cask "geisterhand" do
  version "1.2.0"
  sha256 "eda55a6e052ee2b6de4624c53cf7450099bc4e081534399e3a0262c102e4b763"

  url "https://github.com/geisterhand-io/macos/releases/download/v#{version}/Geisterhand-#{version}.dmg"
  name "Geisterhand"
  desc "macOS screen automation tool with HTTP API"
  homepage "https://github.com/geisterhand-io/macos"

  depends_on macos: ">= :sonoma"

  app "Geisterhand.app"

  # Also install the CLI tool to /usr/local/bin
  binary "#{appdir}/Geisterhand.app/Contents/MacOS/geisterhand"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Geisterhand.app"],
                   sudo: false
  end

  uninstall quit: "com.geisterhand.app"

  zap trash: [
    "~/Library/Preferences/com.geisterhand.app.plist",
    "~/Library/Application Support/Geisterhand",
  ]

  caveats <<~EOS
    Geisterhand requires the following permissions:

    1. Accessibility: System Settings > Privacy & Security > Accessibility
       Add Geisterhand.app to allow keyboard/mouse control

    2. Screen Recording: System Settings > Privacy & Security > Screen Recording
       Add Geisterhand.app to allow screenshots

    After granting permissions, you may need to restart the app.

    The HTTP API runs on http://127.0.0.1:7676

    Quick test:
      curl http://127.0.0.1:7676/status
  EOS
end
