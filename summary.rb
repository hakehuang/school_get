require_relative 'web_crawle'
require_relative 'html_helper'

def summary_schools()
	@sc_tb = ["school_name", "text"].to_html_table({'attributes' => {'colspan' => 2 }})
	file = File.read('schools_high.json', :external_encoding => "UTF-8")
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
=begin	
	summary += "招生报名网".link_to("http://www.shrxbm.cn/").to_html
	summary += "\r\n"
	summary += @sc_tb.to_html
=end
	return summary
end

puts summary_schools()
