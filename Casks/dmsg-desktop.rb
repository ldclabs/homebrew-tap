cask "dmsg-desktop" do
  version "0.3.3"
  sha256 "f0e4b021f456e6c87ac778389cf4bf14af70bf7a635e91ef22e8a535ba3808e1"

  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v#{version}/dMsg-mac-arm64.dmg"
  name "dMsg"
  desc "Desktop workspace and approvals for dMsg"
  homepage "https://dmsg.net/"

  auto_updates true
  depends_on arch: :arm64
  depends_on formula: "dmsg"
  depends_on :macos

  app "dMsg.app"

  # The formula's dmsg owns the daemon and its login registration; ~/.dmsg
  # holds the vault and stays.
  zap trash: [
    "~/Library/Application Support/dMsg",
    "~/Library/Logs/dMsg",
    "~/Library/Preferences/net.dmsg.desktop.plist",
    "~/Library/Saved Application State/net.dmsg.desktop.savedState",
  ]
end
