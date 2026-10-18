cask "dmsg-desktop" do
  version "0.2.2"
  sha256 "3e852b7f62e20d814d2fc72078096973ace2eb43089c5035771aed33a2bfd2f1"

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
