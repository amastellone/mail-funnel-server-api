# rake Bluehelmet:import_wp

require 'Bluehelmet/Parser'
require 'Bluehelmet/Wordpress'
require 'reverse_markdown'
require 'html_massage'
require 'kramdown'

ReverseMarkdown.config do |config|
	config.unknown_tags    = :pass_through
	config.github_flavored = false
	config.tag_border      = ''
end

namespace :Bluehelmet do

	desc "Import Wordpress Files, optionally publish or unpublish all, or publish based on WP publish status"
	task :import_wp => :environment do

		puts "Starting Wordpress Import"

		wp    = Wordpress.new
		posts = wp.posts

		imgs = wp.images

		posts.each do |row|

			puts "*** Importing Article " + row["ID"].to_s + " - " + row["post_title"] + " *** "

			imgs.each do |row| # Image
				puts row["img-data"]
				articles.img = row["img-data"] # TODO: Images for the post
			end

			# HTML -> Markdown
			puts "Converted to Markdown: "
			# result      = ReverseMarkdown.convert(row["post_content"])
			# postContent = result.inspect

			categories = wp.categories(row["ID"])

			article            = Article.new
			article.name       = row["post_title"]
			article.shortname  = row["post_name"]
			article.excerpt    = row["post_excerpt"]
			article.created_at = row["post_date"]
			article.updated_at = row["post_modified"]
			# article.content    = postContent
			article.content    = row["post_content"]
			article.markdown   = false
			article.categories = categories

			disableAll = true

			if disableAll == true
				puts "Article Drafted: " + article.name
				article.published = false
			else
				if row["post_status"].equal?("publish")
					puts "Article Published"
					article.published = true
				elsif row["post_status"].equal?("draft")
					puts "Article Draft"
					article.published = false
				end
			end

			article.save

			puts "Post added - " + article.name
		end
	end

	# Markdown / HTML Converters
	desc "View Articles, converted to markdown (depracated since Markdown column added)"
	task :view_post => :environment do
		wp = Wordpress.new
		wp.view(82).each do |row|

			puts row["post_content"]

			puts "*******************"

			puts "Convert to Markdown: "
			postContent = Upmark.convert(row["post_content"])
			puts postContent
		end
	end
	desc "Convert each Projects' HTML to Markdown (depracated)"
	task :convert_projects => :environment do
		Project.all.each do |project|
			puts project.name
			oldProject      = project.content
			result          = ReverseMarkdown.convert(oldProject)
			project.content = result.inspect
			project.save
		end
	end

	desc "Unpublish all Articles"
	task :unpublish_all_articles => :environment do
		Article.all.each do |article|
			article.published = false
			article.save
		end
	end

	desc "Set all Projects and Articles Markdown False + Article Published to False"
	task :set_entity_options_false => :environment do
		Project.all.each do |project|
			project.markdown = false
			project.save
		end
		Article.all.each do |article|
			article.markdown = false

			article.save
		end
	end

	desc "Test HTML and Markdown Parsers on Projects and Articles"
	task :test_parsers => :environment do
		require 'Bluehelmet/RedcarpetRenderer'
		# wp = Wordpress.new
		# wp.posts.each do |project|
		# content = project["post_content"]
		Project.all.each do |project|
			content = project.content
			puts "******************************"
			puts content
			puts "**********"
			result = ReverseMarkdown.convert(content) # HTML To Markdown
			puts result.inspect
			# doc = Kramdown::Document.new(content, input: "HTML").method_missing
			# result = Kramdown::Converter::Kramdown
			# puts result
			puts "**********"
			# output = Parser.convertMarkdown(result.inspect) # Markdown to HTML
			# output = Kramdown::Document.new(result).to_html
			output = Kramdown::Converter::HTML.convert(result)
			puts output
			puts "******************************"
			puts ""
			puts ""
			puts ""
		end
		return ''
		wp = Wordpress.new
		wp.posts.each do |post|
			content = post["post_content"]
			puts "******************************"
			puts content
			puts "**********"
			result = ReverseMarkdown.convert(content)
			puts result.inspect
			puts "**********"
			output = Parser.convertMarkdown(result.inspect)
			puts output
			puts "******************************"
			puts ""
			puts ""
			puts ""
		end
	end

	# Database
	desc "Reset Database"
	task :reset => :environment do
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:schema:load"].invoke
	end
	desc "Seed Articles and Projects"
	task :seed => :environment do
		Rake::Task["Bluehelmet:import_wp"].invoke
		Rake::Task["db:data:load"].invoke
		Rake::Task["Bluehelmet:convert_projects"].invoke
	end
	desc "Info"
	task :info => :environment do
		Bundler.with_clean_env do
			sh "rails --help | grep Bluehelmet: "
		end
		# Bundler.with_clean_env do
			# sh "rails --help | grep db: "
		# end
	end

	# HEROKU
	desc "Clear Heroku Cache"
	task :heroku_cache => :environment do
		heroku("run rake Bluehelmet:clear_cache")
	end
	desc "Upload Database to Heroku"
	task :push_db => :environment do
		heroku("pg:reset HEROKU_POSTGRESQL_GOLD")
		heroku("pg:push vkaloidis HEROKU_POSTGRESQL_GOLD --app vkaloidis")
	end

	def heroku(cmd)
		Bundler.with_clean_env do
			sh "heroku " + cmd.to_s
		end
	end

	#  Clear Cache
	desc "Clear Cache"
	task :clear_cache => :environment do
		Rake::Task["tmp:clear"].invoke
		Rake::Task["tmp:cache:clear"].invoke
		Rake::Task["assets:clean"].invoke
	end
	desc 'Clear memcache'
	task clear_memcache: :environment do
		::Rails.cache.clear
		CACHE.flush
	end


	# heroku pg:reset HEROKU_POSTGRESQL_GOLD # Reset first
	# heroku pg:push vkaloidis HEROKU_POSTGRESQL_GOLD --app vkaloidis

end
