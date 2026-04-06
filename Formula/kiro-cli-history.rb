class KiroCliHistory < Formula
  desc "Terminal UI for fuzzy-searching, browsing, and resuming Kiro CLI conversations"
  homepage "https://github.com/prabhugr/kiro-cli-history"
  url "https://github.com/prabhugr/kiro-cli-history/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "cd13c46ff971694e69201577cf9506980ae4ce5ae97f9dc44852f8280166eb23"
  license "MIT"

  depends_on "python@3"

  resource "textual" do
    url "https://files.pythonhosted.org/packages/source/t/textual/textual-8.2.3.tar.gz"
    sha256 "3cde52f73e760c4041c86f2ceab37367e7877488db5b5d4b3141c3e0d80f0dd0"
  end

  def install
    libexec.install "kiro_history.py"

    # Create wrapper script
    (bin/"kiro-cli-history").write <<~EOS
      #!/usr/bin/env python3
      import os, sys
      sys.path.insert(0, "#{libexec}")
      from kiro_history import main
      main()
    EOS
    chmod 0755, bin/"kiro-cli-history"
  end

  def caveats
    <<~EOS
      kiro-cli-history requires the 'textual' Python package.
      If not already installed, run:
        pip3 install textual
    EOS
  end

  test do
    assert_match "kiro-cli-history", shell_output("#{bin}/kiro-cli-history --help 2>&1", 2)
  end
end
