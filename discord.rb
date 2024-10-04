def passed_payload(version)
  workflow_id = ENV["SEMAPHORE_WORKFLOW_ID"]
  workflow_url = "https://operately.semaphoreci.com/workflows/#{workflow_id}"
  github_url = "https://github.com/operately/nightly/releases/tag/#{version}"

  { "content": "Operately build is ready!\n\nWorkflow: [#{worfklow_id}](#{workflow_url})\nGitHub Release: [#{version}](#{github_url})" }
end

def failed_payload(version)
  workflow_id = ENV["SEMAPHORE_WORKFLOW_ID"]
  workflow_url = "https://operately.semaphoreci.com/workflows/#{workflow_id}"

  { "content": "Operately build is failed!\n\nWorkflow: [#{worfklow_id}](#{workflow_url})" }
end

result = ENV["SEMAPHORE_PIPELINE_RESULT"]
version = ARGV[0]
webhook_url = ENV["WEBHOOK_URL"]

uri = URI.parse(webhook_url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.request_uri, "Content-Type" => "application/json")
payload = result == "passed" ? passed_payload(version) : failed_payload(version)
request.body = payload.to_json

response = http.request(request)
puts response.body
