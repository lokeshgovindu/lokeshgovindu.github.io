#!/usr/bin/env ruby
# Checks every internal <a href> and <img src> in the built site (_site/)
# resolves to a real file, and that same-page #fragment links point to an
# element that actually exists. Skips external links entirely — this is
# about catching our own mistakes, not monitoring third-party sites.

require "nokogiri"
require "pathname"
require "set"

SITE_DIR = Pathname.new(File.expand_path("../../_site", __FILE__))
EXTERNAL_PREFIXES = %w[http:// https:// mailto: tel: javascript:].freeze

def external?(link)
  EXTERNAL_PREFIXES.any? { |prefix| link.start_with?(prefix) }
end

def resolve_path(link, current_dir)
  path_part = link.split("#", 2).first.to_s
  return current_dir if path_part.empty?

  path_part.start_with?("/") ? SITE_DIR.join(path_part[1..]) : current_dir.join(path_part)
end

def file_for(resolved)
  return resolved.join("index.html") if resolved.to_s.end_with?("/") || !File.extname(resolved.to_s).length.positive?
  resolved
end

broken = []
files = Dir.glob(SITE_DIR.join("**", "*.html").to_s)

files.each do |file|
  html = File.read(file)
  doc = Nokogiri::HTML5(html)
  current_dir = Pathname.new(file).dirname
  relative_source = Pathname.new(file).relative_path_from(SITE_DIR)

  ids = doc.css("[id]").map { |el| el["id"] }.to_set

  (doc.css("a[href]") + doc.css("img[src]")).each do |el|
    link = el["href"] || el["src"]
    next if link.nil? || link.empty? || external?(link)

    if link.start_with?("#")
      fragment = link[1..]
      broken << [relative_source.to_s, link, "no element with id=\"#{fragment}\" on this page"] unless fragment.empty? || ids.include?(fragment)
      next
    end

    resolved = resolve_path(link, current_dir)
    target = file_for(resolved)

    unless File.exist?(target)
      broken << [relative_source.to_s, link, "no file at #{target.relative_path_from(SITE_DIR)}"]
    end
  end
end

if broken.empty?
  puts "No broken internal links found (checked #{files.length} pages)."
  exit 0
end

puts "Found #{broken.length} broken internal link(s):\n"
broken.each { |source, link, reason| puts "  #{source} -> \"#{link}\" (#{reason})" }
exit 1
