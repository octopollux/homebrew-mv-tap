class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.0.1-nightly.20260412-0637"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "0353072d0368b73b378d104879c458c781fe1bc1929f6191674f538594b42de6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "82f61b33c22fbba3b673564f7107ce88fdad5edb1e8ef205e60dfb517adfbc29"
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
