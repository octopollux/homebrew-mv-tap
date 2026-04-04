class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.0.1-nightly.20260404-1918"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "c56d34052d9f9a88d6ca0eed4ba5801b317f57aaae234451c5982f79654bf599"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "ccda22237d0add1ac596c660d301fdc69270909156a69d093fc99125024d5b64"
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
