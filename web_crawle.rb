require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'mechanize'

require_relative 'html_helper'

DAPENG_SITE_IP = "10.192.225.198"

$KEYS = ['招生', '2018', '开放日', '艺术']

$SCHOOLS = {
	'jincai' => "http://www.jincai.sh.cn",
	'jincai_application' => "http://www.jincai.sh.cn/web/JCZX/2730037.htm",
	#'jianpinshiyan' => "http://www.shjpsy.com/web/jpsy/5150001.htm",
	'jianpinshiyan_xiaowu' => 'http://www.shjpsy.com/web/jpsy/5150016.htm',
	'jianpingshiyan_zhaoping' => "http://www.shjpsy.com/web/jpsy/5150007.htm",
	'jianpingxixiao' => "http://www.hsjpx.pudong-edu.sh.cn/homepage/default0.aspx",
	#'pudongmofan' => "http://www.hspdmf.pudong-edu.sh.cn/",
	'pudongmofan_kfr' => 'http://www.hspdmfdx.pudong-edu.sh.cn/Web/PDMF/179009.htm', 
	'luhangnanxiao'  => 'http://www.hslhn.pudong-edu.sh.cn/index.asp',
	'chuanshazhongxuehuaxiaxixiao' => 'http://www.hschzhhxx.pudong-edu.sh.cn/po/1/54/list.html',
	'shanghaifushupudongwaiguoyu' => "http://www.msshw.pudong-edu.sh.cn/",
	'xinzhuyuan'  => "http://www.xinzhuyuan.cn/xzy/xygg/Index.asp", 
	'xinzhuyuan2'  => "http://www.xinzhuyuan.cn/xzy/xygg/ShowClass.asp?ClassID=61",
	'shanghaipudongjiangzhong' => "http://www.jzcj.sh.cn/?m=category&cid=21",
	'jincaibeixiao' => 'http://www.jcbx.pudong-edu.sh.cn/',
	'zhiyuanzhongxue' => 'http://www.hszhiyuan.pudong-edu.sh.cn/web/shzyzx/3900072.htm',
	'wusanzhongxue' => 'http://www.shwszx.com/index.php?m=show&v=list&id=14',
	#'tangzhenzhongxue' => 'http://www.shtzms.com/index.php?v=list&id=16',
	'xiangshazhongxue' => 'http://www.hsxsh.pudong-edu.sh.cn/list_1.html?id=729',
}


def call_school()
	ident = " "*20
    $SCHOOLS.each do |key, iurl|
    	puts "**************"
    	puts key
		begin
			page = Nokogiri::HTML(open(iurl))
			page.css('a').each do |ref|
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


def call_school_agent()
	agent = Mechanize.new
	ident = " "*20
    $SCHOOLS.each do |key, iurl|
    	puts "**************"
    	puts key
			page = agent.get(iurl)
			page.links.each do |ref|
				$KEYS.each do |k|
					if ref.text.include? k
						puts ident + ref.text
						puts URI.join(page.uri.to_s , ref.href)
						#puts ref.href.class
						#puts URI.join(iurl,ref)
					end
				end
			end
		puts "--------------------------"
	end
end

#call_school



call_school_agent()
