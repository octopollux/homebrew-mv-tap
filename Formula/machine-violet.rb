class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "nightly"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "4ea729ce1e9a01d2ff050064700296cca9d19a09d7f6a8ac65fab0d689c55a66"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "9d801751d428f9d5108c632d59e71225cb47fdd22d72e3014aef630e99462d5d"
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
