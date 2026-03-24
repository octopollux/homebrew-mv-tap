class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.0.1-nightly.20260324-0038"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "aa9dc820179354f9655087ab5450fc83ca3e233bf329445616c7c3e38c303b47"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "e19055ec19781b8de91efd3047d38c7d68bb68cc0adbe723ccaa93f0f172b504"
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
