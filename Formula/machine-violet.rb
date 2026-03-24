class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "nightly"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "35d3eb742e1ae738d8e3c47dd0f5836f34392bff05d6d77a3105bd501ee98a30"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "fa9e73c1ca71ddacd734ad31f5251f02a820441c84f733d013affc29773437b4"
    end
  end

  def install
    libexec.install "machine-violet"
    libexec.install "prompts" if Dir.exist?("prompts")
    libexec.install "themes" if Dir.exist?("themes")
    libexec.install "systems" if Dir.exist?("systems")

    chmod 0755, libexec/"machine-violet"
    bin.write_exec_script libexec/"machine-violet"
  end

  test do
    assert_match "machine-violet", shell_output("#{bin}/machine-violet --version")
  end
end
