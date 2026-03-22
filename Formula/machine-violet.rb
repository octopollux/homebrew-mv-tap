class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "nightly"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "159fdde63f4214afd7aa3656a3f53db0f8134fd136887d42e1f064ddfb2608bd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "1fbdd8871c5be1e1068dbd2ff1e6e677ba727346136ebd758730173aa2af950d"
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
