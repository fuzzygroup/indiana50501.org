# 
# Simple build tool to generate a static site
#

#
# Basic idea:
#
# 1. take a given list of directories
# 2. read the file includes/header.html
# 3. open the file index.html in the given directory FOR WRITE
# 4. insert the contents of header.html
# 5. read the file title.text which gets inserted into the __TITLE__ token at the ned
# 6. read the value of index.body in each directory
# 7. read the value of includes/footer.html
# 8. output index.html
# 9. SCP IT UP 

class BuildCleanupViaShell
  def self.write_cleanup_shell(files_to_delete)
    #
    # TODO CLEAN UP THIS WITH AN ABSTRACTION HERE
    #
    directory = "/Users/sjohnson/Sync/coding/html/indiana50501.org"
    output_file = File.join(directory, "cleanup")
    
    #
    # Write header line
    #
    File.write(output_file, "#!/bin/bash")
    
    files_to_delete.each do |file_to_delete|
      rm file_to_delete
    end
    
    # 
    # Close it
    #
    File.close(output_file)
    
    #
    # Make it executable
    #
    exec("chmod +x #{output_file}")
    
  end
end

class BuildCleanup
  def self.past_build_files!(directory)
    possible_deletes = [
      File.join(directory, "index.md"),
      File.join(directory, "index.html")
    ]
    index_title = File.join(directory, "index.title")
    
    delete_ctr = 0
    possible_deletes.each do |possible_delete|
      if BuildCleanup.should_delete?(possible_delete)
        delete_ctr = delete_ctr + 1
        raise "foo -- #{possible_delete}"
        File.delete(possible_delete)
      end
    end    

    # clean up index.title
    # note weird logic exception -- always delete index.title IFF 
    # you deleted index.md or index.html; use delete_ctr to track it    
    if delete_ctr > 0 && File.exists?(index_title)
      File.delete(index_title)
    end
  end
  
  #
  # Tests to determine if should delete automatically generated files
  #   to allow them to be regenerated
  #
  def self.should_delete?(file)
    contents = File.read(file)
    #raise file.inspect
    raise contents.inspect if file =~ /docs/
    return true if contents =~ /Automatically Generated on /
  end
end

class Build

  
  # Build.directories
  def self.directories
    #
    # Where we read content from
    #
    
    # Initialize array we will return our result in
    fully_qualified_dirs = []
    fully_qualified_dirs << Dir.getwd

    # Read from the file directories.txt to get the list of 
    #  directories we are going to get content from 
    dirs = File.readlines('directories.txt')
    
    # loop the directory list and add to the fully qualified list
    dirs.each do |dir|
      fully_qualified_dirs << File.join(Dir.getwd, dir)
    end
    
    fully_qualified_dirs.map(&:chomp).uniq
  end
  
  def self.header_file 
    File.join(Dir.getwd, 'includes/header.html')
  end
  
  def self.footer_file
    File.join(Dir.getwd, 'includes/footer.html')
  end
  
  def self.title_base
    "Indiana 50501 :: "
  end
  
  def self.title_filename(file) 
    Build.basename(file) + '.title'
  end
  
  def self.basename(file)
    filename = File.basename(file)
    parts = filename.split('.')
    parts.first
  end
  
  # handle the special case of index_body.html transitioning to index.html
  # YES THIS IS AN EGREGIOUS HACK and should be GENERALIZED; I'm a bad bad boy 
  def self.handle_index_body_html_generation(file, title_base, page_header, page_footer, directory)
    title_filename = Build.title_filename(file)
    
    puts file
    puts title_filename
    page_title = title_base + File.read(File.join(directory, title_filename))
    page_header = page_header.sub('__TITLE__', page_title)    
    page_body = File.read(File.join(directory, file))
    
    base_filename = "index"
  
    html = File.read(File.join(directory, "index_body.html"))
    #raise page_header.inspect
    full_page = page_header + "\n" + html + "\n" + page_footer
    output_file = File.join(directory, "index.html")
    File.write(output_file, full_page)
    puts "In directory: #{directory}"
    puts "   Writing:  #{output_file}"
    
  end
  
  
  def self.markdown_to_html(file, title_base, page_header, page_footer, directory)
    #require 'github/markup'
    require 'redcarpet'

    # Create a Markdown instance
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
    
    
    title_filename = Build.title_filename(file)
    #raise title_filename.inspect
    puts file
    puts title_filename
    page_title = title_base + File.read(File.join(directory, title_filename))
    page_header = page_header.sub('__TITLE__', page_title)    
    page_body = File.read(file)
  
    base_filename = File.basename(file, ".md")
  
    html = markdown.render(page_body)
    #raise page_header.inspect
    full_page = page_header + "\n" + html + "\n" + page_footer
    output_file = File.join(directory, "#{base_filename}.html")
    File.write(output_file, full_page)
    puts "In directory: #{directory}"
    puts "   Writing:  #{output_file}"
  end
  
  def self.index_page_exists?(directory)
    hit_index = false
    files = Dir.glob("*")
    files.each do |file|
      if file =~ /index.md/
        hit_index = true
      elsif file =~ /index.body/
        hit_index = true
      end
    end
    return hit_index
  end

  def self.generate_index_page(dir)
    
    # need to get a list of all markdown pages in the directory
    
    # need to loop that list of markdown pages and read their .title file
    
    # need to output a sorted list as a list of links
    
  end
  
  def self.run
    dirs = Build.directories
    
    header_file = Build.header_file
    footer_file = Build.footer_file
    
    title_base = Build.title_base
    
    page_header = File.read(header_file)
    page_footer = File.read(footer_file)
    
    dirs.each do |directory|
      puts "\n\n\n\nAT OUTER DIRECTORY PROCESSING LOOP: #{directory}\n\n\n"
      markdown_files = Dir.glob("#{directory}/*.md")
      
      #raise files.inspect
      #raise "foo"
      markdown_files.each do |file|
        puts "At inner loop: file = #{file}"
        if file == "index.html"
          raise "hit it".inspect
        end
        Build.markdown_to_html(file, title_base, page_header, page_footer, directory)
      end
      
      if File.exist?("#{directory}/index_body.html")
        Build.handle_index_body_html_generation("index_body.html", title_base, page_header, page_footer, directory)
      end
      
      if File.exist?("#{directory}/make_index")
        
      end
      #raise "LOOK AT OUTPUT" if directory =~ /ciberchallege/
      #raise "bar"
      # AFTER all files are processed then generate an Index page if needed
      # currently disabled as not yet ready for prime time
      #if 2 == 2
        ##_Build.generate_index_page(directory, title_base, page_header, page_footer)
        #end
    end
  end
  
  
  def self.index_page_exists?(directory)
    hit_index = false
    files = Dir.glob("#{directory}/*")
    files.each do |file|
      if file =~ /index.md/
        hit_index = true
      elsif file =~ /index.body/
        hit_index = true
      elsif file =~ /index.html/
        hit_index = true
      end
    end
    return hit_index
  end
  
  def self.link_file0(file)
    parts = file.split(".")
    "#{parts.first}.html"
  end
  
  def self.link_file(markdown_file)
    raise markdown_file.inspect
    #unpathed_file = 
    #title = File.read()
    
  end
  


  def self.generate_index_page(directory, title_base, page_header, page_footer)
    # clear out old files from past run; ! indicates a destructive method
    BuildCleanup.past_build_files!(directory)

    
    if Build.index_page_exists?(directory) == false
      # get a list of files
      markdown_files = Dir.glob("#{directory}/*.md").sort
      # generate a markdown segment to represent them as an ordered list 
      html_body = []
      html_body << "# Index to #{directory}"
      html_body << "  Automatically Generated on #{Time.now}"
      html_body << ""
      ctr = 1
      markdown_files.each do |markdown_file|
        raise markdown_file.inspect
        Build.link_file(markdown_file)
        html_body << "#{ctr}. [#{markdown_file}](#{Build.link_file(markdown_file)})"
        ctr = ctr + 1
      end
      html_body_as_string = html_body.join("\n")
      File.write(File.join(directory, "index.md"), html_body_as_string)
      File.write(File.join(directory, "index.title"), "Index of Documents in #{directory}")
      Build.markdown_to_html("index.md", title_base, page_header, page_footer, directory)
      
      #.  (and pass it into the filesystem so the markdown_to_html routine can be used as is)
      puts "\n\n\n *** CALLING Build.generate_index_page HERE *** \n\n\n"
      # delete the index.md AFTER it is processed into HTML so it doesn't get picked up on the next pass 
    end
  end
  

  
end

Build.run





#
# KEY ISSUE ON INDEX PAGE GENERATION IS HOW DO YOU KNOW YOU AUTO GENERATED IT TO CLEAN IT UP NEXT PASS
#







# DIRECTORIES.each do |directory|
#   files = Dir.glob("*.md")
#   files.each do |file|
#     markdown_to_html(file)
#
#
#     # #title_filename = File.join(File.basename(file), '.title')
#     # title_filename = "9_reasons_for_non_violence.title"
#     # page_title = TITLE_BASE + File.read(title_filename)
#     # page_header = header_string.sub('__TITLE__', page_title)
#     # page_body = File.read(file)
#     #
#     # base_filename = File.basename(file, ".md")
#     #
#     # html = markdown.render(page_body)
#     #
#     # full_page = page_header + "\n" + html + "\n" + page_footer
#     #
#     # File.write(File.join(directory, "#{base_filename}.html"), html)
#
#   end
#
#   #body = File.read(File.join(directory, 'index.body'))
#   # body = File.read(File.join(directory, 'index.md'))
#   # body =
#
#
#
#  # GitHub::Markup.render(File.join(directory, 'index.html', File.read(file))
#
#   #html = header + "\n" + body + footer_string
#   #File.write(File.join(directory, 'index.html'), html)
# end
#
# def markdown_to_html(file)
#   #title_filename = File.join(File.basename(file), '.title')
#   #title_filename = "9_reasons_for_non_violence.title"
#   page_title = TITLE_BASE + File.read(title_filename)
#   page_header = header_string.sub('__TITLE__', page_title)
#   page_body = File.read(file)
#
#   base_filename = File.basename(file, ".md")
#
#   html = markdown.render(page_body)
#
#   full_page = page_header + "\n" + html + "\n" + page_footer
#
#   File.write(File.join(directory, "#{base_filename}.html"), html)
# end
#
# def index_page_exists?(directory)
#   hit_index = false
#   files = Dir.glob("*")
#   files.each do |file|
#     if file =~ /index.md/
#       hit_index = true
#     elsif file =~ /index.body/
#       hit_index = true
#     end
#   end
#   return hit_index
# end
#
# def generate_index_page()
# end