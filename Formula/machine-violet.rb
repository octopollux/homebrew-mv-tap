class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.0.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/v#{version}/machine-violet-#{version}-darwin-arm64.tar.gz"
      sha256 "6aa06ca24799aaa28a16b224a460e07ea2a7499b6706240e0c37aa7f2be8afa2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/v#{version}/machine-violet-#{version}-linux-x64.tar.gz"
      sha256 "af0c828f57117ed5ffb1304a2c3ae8f22b367f40969c2e9436a1973b04c84879"
    end
  end

  def install
    # The binary expects prompts/, themes/, systems/ next to the executable.
    # Install everything into libexec and symlink the binary into bin.
    libexec.install "machine-violet"
    libexec.install "prompts" if Dir.exist?("prompts")
    libexec.install "themes" if Dir.exist?("themes")
    libexec.install "systems" if Dir.exist?("systems")

    chmod 0755, libexec/"machine-violet"
    bin.write_exec_script libexec/"machine-violet"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/machine-violet --version")
  end
end
