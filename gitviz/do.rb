require 'httparty'

def getInfo(repo, owner) 
	base = "https://api.github.com/repos/#{owner}/#{repo}"
	elastic = "http://127.0.0.1:9200"

	response = HTTParty.put("#{elastic}/repo-#{repo}",  
		:headers => { "Content-Type" => 'application/json' })
	puts response.body

	auth = {:username => "#{ENV['USERNAME']}", :password => "#{ENV['PASSWORD']}"}

	response = HTTParty.get("#{base}/branches", :basic_auth => auth).parsed_response

	branches = []
	master = ""
	response.each do |branch|
		tmp = {}
		tmp['name'] = branch['name']
		tmp['commit'] = branch['commit']['sha']
		tmp['repo'] = repo
		branches.append tmp
		if tmp['name'] == 'master'
			master = tmp['commit']
		end
	end

	branches.each do |branch|
		response = HTTParty.get("#{base}/compare/#{branch['commit']}...#{master}", :basic_auth => auth).parsed_response
		branch['ahead by'] = response['ahead_by']
		branch['behind by'] = response['behind_by']
	end

	branches.each do |branch|
		res = HTTParty.post("#{elastic}/repo-#{repo}/_doc",
			:body => branch.to_json,
			:headers => { 'Content-Type' => 'application/json' })
		puts res.body
	end
end

repos = {}
repos['jenkins'] = 'jenkinsci'
repos['autoscaler'] = 'kubernetes'
repos['timestamper-plugin'] = 'jenkinsci'

repos.each do |repo, owner|
	getInfo(repo, owner)
end