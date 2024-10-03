def passed_payload(version)
  {
    content: "Nightly build is ready for testing!",
    embeds: [
      {
        title: "Nightly Build",
        url: "https://github.com/operately/nightly/releases/tag/#{version}",
        description: "The nightly build is ready for testing.",
        color: 0x00ff00,
        fields: [
          {
            name: "Build",
            value: version,
            inline: true
          },
          {
            name: "Date",
            value: Time.now.strftime("%Y-%m-%d %H:%M:%S"),
            inline: true
          }
        ]
      }
    ]
  }
end

def failed_payload(version)
  {
    content: "Nightly build failed!",
    embeds: [
      {
        title: "Nightly Build",
        url: "https://operately.semaphoreci.com/workflows/#{ENV["SEMAPHORE_WORKFLOW_ID"]}",
        color: 0xff0000,
        fields: [
          {
            name: "Build",
            value: version,
            inline: true
          },
          {
            name: "Date",
            value: Time.now.strftime("%Y-%m-%d %H:%M:%S"),
            inline: true
          }
        ]
      }
    ] 
  }
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
