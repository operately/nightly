require "net/http"
require "json"
require "uri"

version      = ARGV[0]
webhook_url  = ENV["WEBHOOK_URL"]
result       = ENV["SEMAPHORE_PIPELINE_RESULT"]
workflow_id  = ENV["SEMAPHORE_WORKFLOW_ID"]
workflow_url = "https://operately.semaphoreci.com/workflows/#{workflow_id}"
github_url   = "https://github.com/operately/nightly/releases/tag/#{version}"

passed_payload = { "content": "Operately build is ready!\n\nWorkflow: [#{workflow_id}](<#{workflow_url}>)\nGitHub Release: [#{version}](<#{github_url}>)" }.to_json
failed_payload = { "content": "Operately build failed!\nWorkflow: [#{workflow_id}](<#{workflow_url}>)" }.to_json

uri = URI.parse(webhook_url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.request_uri, "Content-Type" => "application/json")
request.body = result == "passed" ? passed_payload : failed_payload

response = http.request(request)
puts response.body
