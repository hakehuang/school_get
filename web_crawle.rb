require "rubygems"
require "nokogiri"
require "open-uri"
require "yaml"
require "mechanize"
require "json"

require_relative "html_helper"

year = "2019"

$KEYS = ["欢迎#{year}年应届优秀初中毕业生登陆上中招生系统",
	 "#{year}年我校",
	 "#{year}",
	 "#{year}年上海市高中学校",
	 "#{year}年上海市高中学校“提前招生录取”主要日程安排",
	 #"招生","开放日","提前批面试通知",
	 "#{year} “初高中联谊”校园开放日活动通知",
	 "#{year}年七宝中学校园开放日安排",
	 "#{year}年南洋模范中学校园开放日公告",
	 "#{year}年上海市进才中学",
	 "#{year}年上海市控江中学",
	 "#{year}年上海市延安中学",
	 "#{year}年上海市浦东复旦附中",
	 #"提前招生录取",
	 "市西中学#{year}",
	 "#{year}年上海市大同中学自主招生公告",
	 "#{year}年上海市格致中学",
	 "#{year}年上海市奉贤中学校园开放日公告",
	 "#{year}年上海市行知中学",
	 "#{year}年市北中学校",
	 "#{year}年上海市松江二中",
	 "#{year}年上海市育才中学校园开放日活动方案",
	 "#{year}年上海市上海中学东校",
	 "#{year}年上海市第二中学",
	 "#{year}年上海大学附属中学",
	 "上海市第三女子中学#{year}年校园开放日公告",
	 "华东师大一附中#{year}年",
	 #"提前批",
	 "#{year}年上外附属大境中学校园开放日活动公告",
	 "#{year}年南洋中学校园开放日活动方案",
	 "#{year}年上海市嘉定一中",
	 "#{year}年上海市松江一中",
	 "上海市回民中学#{year}学年高中自主招生报名",
	 "#{year}年“校园开放日”公告",
	 "#{year}年上海市朱家角中学",
	 #"录取", "面谈", "面试", "笔试", "提前招生"
	]

=begin
$SCHOOLS = {
	"jincai" => "http://www.jincai.sh.cn",
	"jincai_application" => "http://www.jincai.sh.cn/web/JCZX/2730037.htm",
	"jianpinshiyan" => "http://www.shjpsy.com/web/jpsy/5150001.htm",
	"jianpinshiyan_xiaowu" => "http://www.shjpsy.com/web/jpsy/5150016.htm",
	"jianpingshiyan_zhaoping" => "http://www.shjpsy.com/web/jpsy/5150007.htm",
	"jianpingxixiao" => "http://www.hsjpx.pudong-edu.sh.cn/homepage/default0.aspx",
	#"pudongmofan" => "http://www.hspdmf.pudong-edu.sh.cn/",
	"pudongmofan_kfr" => "http://www.hspdmfdx.pudong-edu.sh.cn/Web/PDMF/179009.htm", 
	"luhangnanxiao"  => "http://www.hslhn.pudong-edu.sh.cn/index.asp",
	"chuanshazhongxuehuaxiaxixiao" => "http://www.hschzhhxx.pudong-edu.sh.cn/po/1/54/list.html",
	"shanghaifushupudongwaiguoyu" => "http://www.msshw.pudong-edu.sh.cn/",
	"xinzhuyuan"  => "http://www.xinzhuyuan.cn/xzy/xygg/Index.asp", 
	"xinzhuyuan2"  => "http://www.xinzhuyuan.cn/xzy/xygg/ShowClass.asp?ClassID=61",
	"shanghaipudongjiangzhong" => "http://www.jzcj.sh.cn/?m=category&cid=21",
	"jincaibeixiao" => "http://www.jcbx.pudong-edu.sh.cn/",
	"zhiyuanzhongxue" => "http://www.hszhiyuan.pudong-edu.sh.cn/web/shzyzx/3900072.htm",
	"wusanzhongxue" => "http://www.shwszx.com/index.php?m=show&v=list&id=14",
	"tangzhenzhongxue" => "http://www.shtzms.com/index.php?v=list&id=16",
	"xiangshazhongxue" => "http://www.hsxsh.pudong-edu.sh.cn/list_1.html?id=729",
}
=end


def call_school()
	ident = " "*20
    $SCHOOLS.each do |key, iurl|
    	puts "**************"
    	puts key
		begin
			page = Nokogiri::HTML(open(iurl))
			page.css("a").each do |ref|
				$KEYS.each do |k|
					if ref.content.include? k
						puts ident + ref.content
						puts URI.join(iurl,ref["href"])
					end
				end
			end
		rescue
			puts "error in #{key}"
		end
		puts "--------------------------"
	end
end


def call_school_agent(schools)
	agent = Mechanize.new
	ident = " "*20
	messages = {}
    schools.each do |key, iurl|
    	puts "**************"
    	puts key
    	messages[key] = []
    	begin
		page = agent.get(iurl)
		page.links.each do |ref|
			$KEYS.each do |k|
				if ref.text.include? k
					puts ident + ref.text
					puts URI.join(page.uri.to_s , ref.href)
					messages[key].insert(-1, {ref.text => URI.join(page.uri.to_s , ref.href).to_s}) 
					#puts ref.href.class
					#puts URI.join(iurl,ref)
				end
			end
		end
		rescue
			puts "error on #{key} with #{iurl}"
		end
		puts "--------------------------"
	end
	return messages
end

#call_school

#file = File.read("schools.json", :external_encoding => "UTF-8")
#schools = JSON.parse(file)
#puts schools
#schools.each do |k,v|
#	puts k.encoding
#	puts k
#end
#puts call_school_agent(schools)
