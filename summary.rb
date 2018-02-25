require_relative 'web_crawle'
require_relative 'html_helper'

def summary_schools()
	@sc_tb = ["school_name", "text"].to_html_table({'attributes' => {'colspan' => 2 }})
	file = File.read('schools.json')
	schools = JSON.parse(file)
	school_lists = call_school_agent(schools)
	hsh = {'attributes' => {'colspan' => 2 }}
	summary = ""

	school_lists.each do |k, v|
		v.each do |link|
			link.each do |kk,vv|
				ss = kk.link_to(vv)
				[k, ss].add_row_to_table(@sc_tb, hsh)
			end
		end
	end
	summary += @sc_tb.to_html
	return summary
end

puts summary_schools()