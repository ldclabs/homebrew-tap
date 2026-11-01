cask "dmsg-desktop" do
  version "1.3.0"
  sha256 "d1942e7e62c6b940773c8ffe47592f23a62a104de02181e9373bb1484f012865"

  url "https://github.com/ldclabs/ic-panda/releases/download/#{version}/dMsg-mac-arm64.dmg"
  name "dMsg"
  desc "Desktop workspace and approvals for dMsg"
  homepage "https://dmsg.net/"

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
