require 'rake/rdoctask'

task :default => [:test]

task :test do
	ruby "test/test.rb"
end

=begin
	See: http://rake.rubyforge.org/classes/Rake/RDocTask.html
	
	Usage: 
	
	rdoc
		Main task for this RDOC task.
	:clobber_rdoc
		Delete all the rdoc files. This target is automatically added to the main clobber target.
	:rerdoc
		Rebuild the rdoc files from scratch, even if they are not out of date.
=end
Rake::RDocTask.new do |rd|
	rd.main = "README"
	rd.rdoc_files.include("README", "lib/**/*.rb")
end

task :package => [:test, :rerdoc] do
	sh "tar -cf sudoku.tar *"
	sh "gzip sudoku.tar"
end