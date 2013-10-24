require 'minitest/spec'

class TestVisualStudioInstall < MiniTest::Chef::TestCase

  def test_visual_studio_was_installed
    visualstudiodir = File.join(ENV['PROGRAMFILES'],
      'Microsoft Visual Studio 11.0\\Common7\\IDE\\devenv.exe')
    assert File.exists?(visualstudiodir)
  end

  def test_nuget_allowed_environment_variable_set
    assert ENV['EnableNuGetPackageRestore'] != ''
  end
end
