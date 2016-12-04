require "net/http" 
require "json"
require "rubygems"

def getData 
    requestString = "https://data.lacity.org/resource/x4zi-qhep.json"
    sampleURI = URI(requestString)
    sampleResponse = Net::HTTP.get(sampleURI)
    parsedResponse = JSON.parse(sampleResponse)
end

def formatByDate (data)
    data.map do |event|
        date = event["event_date_time_start"]
        new_date = date[0...10]
        new_time = date[11...16]
        # year = date[0]
        # month = date[1]
        # day_and_time = date[2]
        # "This event happened on #{day_and_time} - #{month} #{year}"
        name = event["event_name"]
        "#{name} is happening on #{new_date} at #{new_time} PST." 
    end
end


def ask_for_data_from_giphy(search_term)
	new_search_term = search_term.gsub(" ", "+")
	request_string = "http://api.giphy.com/v1/gifs/search?q=#{new_search_term}&api_key=dc6zaTOxFJmzC"
	
	sample_uri = URI(request_string) #opens a portal to the data at that link
	sample_response = Net::HTTP.get(sample_uri) #go grab the data in the portal
	sample_parsedResponse = JSON.parse(sample_response) #makes data easy to read
	# data comes back as a hash with info stored in key :data as an array
	data = sample_parsedResponse["data"]
	# data is now an array containing hashes of the gifs
	data.sample["images"]["fixed_height"]["url"]
end

# def eventType
#     data.map do |event|
#         type = event["type_of_event"]
#         "This event is #{type_of_event}."
#     end
# end

# def subjectMatter 
#     data.map do |event|
#         subject =    event[  "subject_matter"]
        
#     end 
# end 
  
# def imformationWebsite 
#     data.map do |event| 
#         subject = event["information_website"]
        
#     end 
# end 
   
    
    
    
    
    
    
