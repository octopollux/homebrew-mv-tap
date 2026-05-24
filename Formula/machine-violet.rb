class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.0.1-nightly.20260524-0524"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "e089ab802f294758ecb3405d37e0d48ca42c04da23e97c06af39e063216839e6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "eba30a40995bbebb4a53cb6dd6c257714969c0906b1d55c61d67c117f54fbe12"
    end
  end

  def install
    libexec.install "MachineViolet"
    libexec.install "prompts" if Dir.exist?("prompts")
    libexec.install "themes" if Dir.exist?("themes")
    libexec.install "systems" if Dir.exist?("systems")

    chmod 0755, libexec/"MachineViolet"
    # Expose as lowercase `machine-violet` for CLI convention
    (bin/"machine-violet").write_env_script libexec/"MachineViolet"
  end

  test do
    assert_match "MachineViolet", shell_output("#{bin}/machine-violet --version")
  end
end
