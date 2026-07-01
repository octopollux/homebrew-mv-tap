class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.1.0-nightly.20260701-0737"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "95732415e5a1cdd9065ebbfa06b97377b132b24e2c8d6c2b632a6c32b3fb3690"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "4e5dbe3d24074219a08113cccc0b3ce6cf53846f0d740b8a5907a2faf555a93d"
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
